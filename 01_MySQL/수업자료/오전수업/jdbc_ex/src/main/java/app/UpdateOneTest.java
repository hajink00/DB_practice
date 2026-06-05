package app;

import com.mongodb.client.MongoCollection;
import com.mongodb.client.model.Updates;
import com.mongodb.client.result.InsertOneResult;
import com.mongodb.client.result.UpdateResult;
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import static com.mongodb.client.model.Filters.eq;

public class UpdateOneTest {
    public static void main(String[] args) {
        // Database클래스를 쓰는 순간 static{ }이 실행 됨. db 서버 연결, db 연결이 준비가 됨
        MongoCollection<Document> collection = Database.getCollection("users");
        System.out.println("3. todo 컬렉션 연결 성공");


        // 업데이트할 때, 조건을 만족하는 document를 찾아서 키를 수정
        Bson query = eq("_id", new ObjectId("6a22510851ede08a8b03ded2"));

        Bson updates = Updates.combine(
                Updates.set("name", "수정할 값")
        );

        UpdateResult result = collection.updateOne(query, updates);
        System.out.println("업데이트 요청 결과 >> " + result);

        Database.close();
    }
}