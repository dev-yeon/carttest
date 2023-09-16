//
//  Service.swift
//  AppleStoreAdmin
//
//  Created by woojin Shin on 2023/09/06.
//

import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import SwiftUI


//Encode하는 데이터객체 Dictinary로 변환해주기
extension Encodable {
    
    func toDictionary() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()
        
        for (label, value) in mirror.children {
            if let label {
                if let _ = value as? DocumentID<String> { //=> @DocumentID 프로퍼티래퍼 사용할때 필터해주기위해 사용했던 구문.
                    
                } else {
                    dictionary[label] = value
                }
            }
            
        }
        return dictionary
    }
    
    ///nil 인 필드 제외하고 생성
    func toDictionaryNotNil() -> [String: Any] {
        let mirror = Mirror(reflecting: self)
        var dictionary = [String: Any]()
        
        for (label, value) in mirror.children {
            if let label {
                if let _ = value as? DocumentID<String> {   //=> @DocumentID 프로퍼티래퍼 사용할때 필터해주기위해 사용했던 구문.
                    
                } else if !(Mirror(reflecting: value).displayStyle == .optional && Mirror(reflecting: value).children.isEmpty) {
                    dictionary[label] = value
                }
            }
        }
        return dictionary
    }
    
}


///Service  Enum
struct ServiceType {
    /// 컬렉션 Enum
    enum ColName: String {
        case kind = "Kind"
        case itemInfo = "ItemInfo"
        case user = "Users"
        case order = "Order"
        case payment = "Payment"
    }
    
    /// 조건타입 Enum
    enum Where {
        case equal          // ==
        case lessThan       // <
        case overThan       // >
        case lessOrEqual    // <=
        case overOrEqual    // >=
        case notEqual       // !=
        case or             // in
    }
    
    /// 정렬타입 Enum
    enum Sort {
        case asc        //오름차순
        case desc       //내림차순
    }
    
}


/// Firebase CRUD
final class Service {

    ///Firestore DB
    private let db = Firestore.firestore()


    ///READ, FETCH 1개 데이터
    ///- collection : 컬렉션명 Enum
    ///- documentID: 문서번호
    ///- completion: 해당 문서번호에 해당하는 형식의 객체를 파라미터로 return 시켜준다.
    func fetchOneData<T: Codable>( collection col: ServiceType.ColName, documentID docID: String, completion: @escaping (T) -> Void ) {
        guard docID != "" else { return }

        let docRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)

        docRef.getDocument(as: T.self) { result in
            switch result {
            case .success(let success):
                print("Fetch 성공 : \(success)")

                completion(success)

            case .failure(let error):
                print("Fetch중 에러 : \(error.localizedDescription)")

            }
        }
    }


    ///Dictionary 형태로 Return
    ///- collection : 컬렉션명 Enum
    ///- documentID: 문서번호
    ///- completion: 해당 문서번호에 해당하는 형식의 객체를 파라미터로 return 시켜준다.
    func fetchOneData( collection col: ServiceType.ColName, documentID docID: String, completion: @escaping ([String : Any]) -> Void ) {
        guard docID != "" else { return }

        let docRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)

        docRef.addSnapshotListener { document, error in
            if let document = document, document.exists {
                let dataDescription = document.data()//.map(String.init(describing:)) ?? "nil"

                if let dataDescription {
                    completion(dataDescription)
                } else {
                    completion([:])
                }

            } else {
                print("Document does not exist")
                return
            }
        }

    }



    ///   onAppear()에서 호출바랍니다.
    ///서버에서 가져올 데이터를 담을 구조체( 데이터 객체 )의 배열을 클로저 매개변수로 반환
    ///Data의 필드명이 데이터객체의 프로퍼티명과 일치하지 않거나 없을 경우 런타임 에러가 나기때문에 사용을 비추천 ->> 프로퍼티를 옵셔널로 처리하면 에러 안남.
    /// - collection: 컬렉션명 Enum
    /// - whereField: 조건을 입력할 Field명 ( String? )
    /// - whereType: 조건 타입 ex) equalTo( == ), lessThan( < ) etc...
    /// - whereData: 조건 값 ( Any? )
    /// - orderField: 정렬 Field명 ( String? )
    /// - orderType: 정렬 (오름차순, 내림차순) Enum
    /// - limitCount: 데이터 fetch개수 ==> 0이면 전체조회
    /// - completion: [ T ] -> Void  ==> 실제 데이터배열 Return
    func fetchAll<T: Codable>( collection col: ServiceType.ColName,
                               whereFields conditions: [String]? = nil,
                               whereTypes types: [ServiceType.Where] = [],
                               whereDatas: [Any]? = nil,
                               orderField orderby: String? = nil,
                               orderType: ServiceType.Sort = .asc,
                               limitCount: Int = 0,
                               completion: @escaping ([T]) -> Void ) {

        
        var colRef: Query
        
        colRef = db.collection("\(col.rawValue)")
        
        if let conditions {
           
            var counts = [String: Int]()
            var disConditions = [String]()  //필드중복값 제거된 배열

            for element in conditions {
                if let count = counts[element] {
                    counts[element] = count + 1
                } else {
                    counts[element] = 1
                    disConditions.append(element)
                }
            }
            

            //타입 없을경우 equal로 넣어주기 conditions만큼
            var typesInsideFunc = types
            if typesInsideFunc.isEmpty {
                for _ in conditions {
                    typesInsideFunc.append(.equal)
                }
            }
            
            
            if var whereDatas {
                guard conditions.count == whereDatas.count &&
                      conditions.count == typesInsideFunc.count else {

                    print("조건필드와 조건데이터, 조건타입 배열의 개수가 일치하지 않습니다.")
                    return
                }
                
//                print("whereData \(whereDatas)")
                //필드 개수만큼만 반복
                for index in disConditions.indices {
                    var dataCnt: Int = 0
                    var newDatas: [Any] = .init()
                    var newType: ServiceType.Where
                    
                    //중복필드에 해당하면 진입
                    if counts.contains(where: { key, cnt in
                        dataCnt = cnt
                        return key == disConditions[index]
                    }) {
                        for temp in (0 ..< dataCnt).reversed() {    //reverse해서 반복문을 돌려야 out of index 에러가 나지않는다. 배열값을 지워줄것이기 때문.
                            if !whereDatas.isEmpty {
                                newDatas.append(whereDatas[temp])   //새로운 배열에 넣어준 후
                                whereDatas.remove(at: temp) //기존 배열에서는 지워준다.-> 그래야 다른 필드의 데이터도 0번째 인덱스부터 가져올 수 있음.
                                typesInsideFunc.remove(at: temp)      //기존 배열에서 타입 지워준다.
                            }
                        }
                        
                        newType = .or       //여러값이 들어갈 경우 or를 써준다.
                        
                        
                    } else {
                        newDatas.append(whereDatas.first as Any)   //새로운 배열에 넣어준 후
                        whereDatas.removeFirst() //기존 배열에서는 지워준다.->그래야 다른 필드의 데이터도 0번째 인덱스부터 가져올 수 있음.
                        newType = typesInsideFunc.first!    //type도 새로운 값에 할당
                        typesInsideFunc.removeFirst() //type의 기존배열에서는 지워준다.

                        
                    }
                    
                    print("type : \(newType), 필드 : \(disConditions[index]), data : \(newDatas)")
                    
                    
                    switch newType {
                    case .equal:
                        colRef = colRef.whereField("\(disConditions[index])", isEqualTo: newDatas)
                    case .lessThan:
                        colRef = colRef.whereField("\(disConditions[index])", isLessThan: newDatas)
                    case .overThan:
                        colRef = colRef.whereField("\(disConditions[index])", isGreaterThan: newDatas)
                    case .lessOrEqual:
                        colRef = colRef.whereField("\(disConditions[index])", isLessThanOrEqualTo: newDatas)
                    case .overOrEqual:
                        colRef = colRef.whereField("\(disConditions[index])", isGreaterThanOrEqualTo: newDatas)
                    case .notEqual:
                        colRef = colRef.whereField("\(disConditions[index])", isNotEqualTo: newDatas)
                    case .or:
                        colRef = colRef.whereField("\(disConditions[index])", in: newDatas)
                    }
                    
                    
                }
                
            } else {
                print("Err: 매개변수 whereData에 값을 입력하지 않았습니다.")
                return
            }

        }


        //정렬
        if let orderby {
            switch orderType {
            case .asc:
                colRef = colRef.order(by: orderby)
            case .desc:
                colRef = colRef.order(by: orderby, descending: true)
            }

        }


        if limitCount != 0 {
            colRef = colRef.limit(to: limitCount)
        }


        colRef.getDocuments() { [self] snapShot, error in
            if let error {
                print("문서번호 못가져옴 : \(error)")
                completion([])

            } else {
                var fetchedDatas: [T] = []   //초기화

                if let snapShot {
                    for document in snapShot.documents {

                        let docID = document.documentID

//                        print("문서ID :  \(document)")

                        db.collection("\(col.rawValue)").document(docID).getDocument(as: T.self) { result in
                            switch result {
                            case .success(let success):
//                                print("Fetch 성공 : \(success)")
                                fetchedDatas.append(success)

                                completion(fetchedDatas)

                            case .failure(let error):
                                print("Fetch중 에러 : \(error.localizedDescription)")

                            }
                        }
                    }
                }

            }

        }

    }


    ///Dictionary 형식으로 결과값 반환
    ///where는 데이터를 가져오는 조건이지 검색용필터가 아닙니당
    ///배열로 가져옴 [[String : Any]] //
    ///   onAppear()에서 호출바랍니다.
    /// - collection: 컬렉션명 Enum
    /// - whereField: 조건을 입력할 Field명 ( String? )
    /// - whereType: 조건 타입 ex) equalTo( == ), lessThan( < ) etc...
    /// - whereData: 조건 값 ( Any? )
    /// - orderField: 정렬 Field명 ( String? )
    /// - orderType: 정렬 (오름차순, 내림차순) Enum
    /// - limitCount: 데이터 fetch개수 ==> 0 이면 전체조회
    /// - completion: [[String : Any]] -> Void  ==> 실제 데이터배열 Return
    func fetchAll( collection col: ServiceType.ColName,
                   whereFields conditions: [String]? = nil,
                   whereTypes types: [ServiceType.Where]? = nil,
                   whereDatas: [Any]? = nil,
                   orderField orderby: String? = nil,
                   orderType: ServiceType.Sort = .asc,
                   limitCount: Int = 0,
                   completion: @escaping ([[String : Any]]) -> Void ) {


        var colRef: Query
        
        
        colRef = db.collection("\(col.rawValue)")

        if let conditions {
            if let whereDatas, let types {
                
                for index in whereDatas.indices {
                    
                    switch types[index] {
                    case .equal:
                        colRef = colRef.whereField("\(conditions[index])", isEqualTo: whereDatas[index])
                    case .lessThan:
                        colRef = colRef.whereField("\(conditions[index])", isLessThan: whereDatas[index])
                    case .overThan:
                        colRef = colRef.whereField("\(conditions[index])", isGreaterThan: whereDatas[index])
                    case .lessOrEqual:
                        colRef = colRef.whereField("\(conditions[index])", isLessThanOrEqualTo: whereDatas[index])
                    case .overOrEqual:
                        colRef = colRef.whereField("\(conditions[index])", isGreaterThanOrEqualTo: whereDatas[index])
                    case .notEqual:
                        colRef = colRef.whereField("\(conditions[index])", isNotEqualTo: whereDatas[index])
                    case .or:
                        colRef = colRef.whereField("\(conditions[index])", in: [whereDatas[index]])
                    }
                }
                
                
            } else {
                print("Err: 매개변수 whereData에 값을 입력하지 않았습니다.")
                return
            }

        }

        //정렬
        if let orderby {
            switch orderType {
            case .asc:
                colRef = colRef.order(by: orderby)
            case .desc:
                colRef = colRef.order(by: orderby, descending: true)
            }

        }

        //데이터 갯수제한
        if limitCount != 0 {
            colRef = colRef.limit(to: limitCount)
        }

        //문서의 변화가 생기면 감지.
        colRef.addSnapshotListener { snapShot, error in
            if let error {
                print("문서번호 못가져옴 : \(error.localizedDescription)")
                completion([[:]])

            } else {
                var fetchedDatas = [[String : Any]]()   //초기화

                if let snapShot {

                    for document in snapShot.documents {

                        let documentData = document.data()

                        fetchedDatas.append(documentData)


                    }
                    print("데이터 개수 \(fetchedDatas.count)")
                    completion(fetchedDatas)

                }

            }
        }

    }

    ///FireStore Update
    ///data에 정의된 해당 필드만 update 된다.
    ///- collection: collection 선택
    ///- documentID: 문서번호
    ///- data: 업데이트할 Data 객체
    func update<T: Codable>( collection col: ServiceType.ColName, documentID docID: String, data: T, completion: @escaping (Bool) -> Void ) {

        guard docID != "" else { return }

        let docRef = db.collection("\(col.rawValue)").document(docID)

        var dataDic = [String : Any]()


        dataDic = data.toDictionaryNotNil() //nil값인 프로퍼티를 제외하고 Dictionary 형식으로 변환

        //트랜잭션 -> 안해도 되는거 같은데... 각각 다른 환경에서 테스트 안해봐서 모르겠다...    보류
        //        db.runTransaction({ (transaction, _) -> Any? in
        //            transaction.updateData( dataDic, forDocument: docRef )
        //
        //        }) { (object, error) in
        //            if let error {
        //                print("Error updating : \(error.localizedDescription)")
        //            } else {
        //                print("Update 완료 : \(object!)")
        //            }
        //
        //        }

        docRef.updateData( dataDic ) { err in
            if let err {
                print("Error updating : \(err.localizedDescription)")
                completion(false)
            } else {
                print("Update 완료")
                completion(true)
            }
        }

    }
    
    ///FireStore Update
    ///data에 정의된 해당 필드만 update 된다.
    ///- collection: collection 선택
    ///- documentID: 문서번호
    ///- data: 업데이트할 Data 객체
    func update( collection col: ServiceType.ColName, documentID docID: String, data: [String : Any], completion: @escaping (Bool) -> Void ) {

        guard docID != "" else { return }

        let docRef = db.collection("\(col.rawValue)").document(docID)

        docRef.updateData( data ) { err in
            if let err {
                print("Error updating : \(err.localizedDescription)")
                completion(false)
            } else {
                print("Update 완료")
                completion(true)
            }
        }

    }


    ///ADD 추가 DocumentID는 알아서 따진다. => addDocument 메서드 사용시
    ///데이터 객체로 addDocument 사용시 nil값인 프로퍼티들은 생략이 되기때문에 구조 그대로 가져가기 위해서 Dictionary로 변환하여 add 해준다.
    ///addDocument 메서드를 통해 id값을 생성 후 해당 id값을 id필드를 구현하여 update해준다.
    ///- collection: 컬렉션 Enum
    ///- data: 데이터객체 where Encodable
    func add<T: Encodable>( collection col: ServiceType.ColName, data: T, completion: @escaping (Bool) -> Void ) {
//        print(data)
        let colRef: CollectionReference = db.collection("\(col.rawValue)")

//        var dicData = [String : Any]()
//        print("data :\n \(data)")
//        dicData = data.toDictionary()   //Dictionary형태로 변환
//        print("dicData =\n \(dicData)")

        var newDocRef: DocumentReference?

        do {
            newDocRef = try colRef.addDocument( from: data ) { error in
                if let error = error {
                    completion(false)
                    print("신규추가 중 에러 : \(error.localizedDescription)")

                } else {
                    completion(true)
                    print("추가완료 \(newDocRef!.documentID)")
//                    if let newDocRef {
//                        let UID = newDocRef.documentID
//                        colRef.document("\(UID)").updateData( ["id" : UID] ) { err in
//                            if let err {
//                                print("Error updating : \(err.localizedDescription)")
//                            } else {
//                                print("ADD: UID Update 완료 UID = \(UID)")
//                            }
//                        }
//
//                    }
                }
            }
        } catch {
            completion(false)
            print("신규추가 중 에러2 : \(error.localizedDescription)")
        }
    }

    
    ///DocumentID를 직접 추가
    func add<T: Encodable>( collection col: ServiceType.ColName, docID: String, data: T, comletion: @escaping (Bool) -> Void ) {
//        print(data)
        let colRef: CollectionReference = db.collection("\(col.rawValue)")

        let newDocRef: DocumentReference = colRef.document(docID)

        do {
            try newDocRef.setData( from: data ) { error in
                if let error = error {
                    comletion(false)
                    print("신규추가 중 에러 : \(error.localizedDescription)")

                } else {
                    comletion(true)
                    print("추가완료 \(newDocRef.documentID)")
                }
            }
        } catch {
            comletion(false)
            print("신규추가 중 에러2 : \(error.localizedDescription)")
        }
    }
    
    
    ///REMOVE 삭제
    ///- collection: 컬렉션 Enum
    ///- documentID: 삭제하려는 문서번호 ( 보통 객체의 id 값 )
    func remove( collection col: ServiceType.ColName, documentID docID: String, completion: @escaping (Bool) -> Void ) {
        guard docID != "" else {
            return
        }

        //둘다 똑같음 document로 Path 설정만 잘해줘도 같은 기능을 함.
//        let dbRef: DocumentReference = db.collection("\(col.rawValue)").document(docID)
        let dbRef: DocumentReference = db.document("\(col.rawValue)/\(docID)")

//        print("\(dbRef)")

        dbRef.delete() { error in
            if let error {
                print("Delete 에러 : \(error.localizedDescription)")
                completion(false)
            } else {
                print("Delete 완료")
                completion(true)

            }
        }

    }


    ///한번에 여러작업을 처리할때 사용
    ///ex) post 컬랙션에 add하고 post ID값을 my컬랙션에 업데이트 한다.
    func makeBatch( collection col: ServiceType.ColName, documentID docID: String ) {
//        let docRef = db.collection("\(col.rawValue)").document(docID)
//
//        let batch = db.batch() //작업박스를 생성

        //처리할거 하고 commit하기

        //batch.setData(<#T##data: [String : Any]##[String : Any]#>, forDocument: <#T##DocumentReference#>)
        //batch.updateData(<#T##fields: [AnyHashable : Any]##[AnyHashable : Any]#>, forDocument: <#T##DocumentReference#>)
        //batch.deleteDocument(<#T##document: DocumentReference##DocumentReference#>)

//        batch.commit(){ err in
//        if let err = err {
//            print("Error writing batch \(err)")
//        } else {
//            print("Batch write succeeded.")
//        }
    }

}
