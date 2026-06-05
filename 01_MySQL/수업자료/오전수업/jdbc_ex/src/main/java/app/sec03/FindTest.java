package app.sec03;

import app.sec01.Database;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import org.bson.Document;
import org.bson.conversions.Bson;

import java.util.Iterator;

import static com.mongodb.client.model.Filters.eq;

public class FindTest {
    public static void main(String[] args) {
        // DB 연결 객체 얻어오기
        MongoCollection<Document> collection = Database.getCollection("study");

        // FindIterable : 조회 결과를 반복자(Iterator) 형태로 반환할 수 있는 객체
        FindIterable<Document> doc = collection.find();

        // 반복자 형태로 변환
        Iterator it = doc.iterator();

        while(it.hasNext()){ // 다음 행이 있으면 true
            // it.next() : 다음 행(문서 반환)
            System.out.println("FindResultRow : " + it.next());
        }

    }






}
