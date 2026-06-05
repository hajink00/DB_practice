package app.sec02;

import app.sec01.Database;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.InsertManyResult;
import com.mongodb.client.result.InsertOneResult;
import org.bson.Document;

import java.util.ArrayList;
import java.util.List;

public class InsertManyTest {
    public static void main(String[] args) {
        // MongoDB의 collection 연결
        MongoCollection<Document> collection = Database.getCollection("study");

        // 한번에 여러개 추가 --> document를 넣을 list 생성
        List<Document> insertList = new ArrayList<>();

        // 넣을 document 생성
        Document document1 = new Document();
        Document document2 = new Document();

        // 각 document의 값 넣어주기
        document1.append("title", "Dune2 영화 보기");
        document1.append("desc", "이번 주말 IMAX로Dune2 영화보기");
        document1.append("done", false);

        document2.append("title", "Java MongoDB 연동");
        document2.append("desc", false);
        document2.append("done", false);

        // 문서 리스트에 추가
        insertList.add(document1);
        insertList.add(document2);

        // 한 번에 insert
        InsertManyResult result = collection.insertMany(insertList);

        // 생성된 문서의 _id 필드값 얻어오기
        System.out.println("InsertManyResult : " + result.getInsertedIds());

        // 데이터베이스 연결 종료 및 리소스 정리
        Database.close();

    }




}
