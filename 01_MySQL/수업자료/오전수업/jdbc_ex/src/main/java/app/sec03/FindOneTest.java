package app.sec03;

import app.sec01.Database;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import static com.mongodb.client.model.Filters.*;
// import static : 클래스명을 생략하고 메소드명만 작성 가능
import org.bson.Document;
import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import java.util.Iterator;
import java.util.logging.Filter;

import static com.mongodb.client.model.Filters.eq;

public class FindOneTest {
    public static void main(String[] args) {
        // DB 연결 객체 얻어오기
        MongoCollection<Document> collection = Database.getCollection("study");

        // 존재하는 _id
        String id = "6a226b29ac5dd813a0070147";

        // Filters.eq()
        Bson query = eq("id", new ObjectId(id));

        // 조건을 만족하는 결과 중 1행(문서 1개)만 조회

        // FindIterable : 조회 결과를 반복자(Iterator) 형태로 반환할 수 있는 객체
        Document doc = collection.find(query).first();

        System.out.println("FindByIdResult : " + doc);

        Database.close();

    }






}
