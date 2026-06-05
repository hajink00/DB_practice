package app;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

import java.util.Iterator;

import org.bson.conversions.Bson;
import org.bson.types.ObjectId;

import static com.mongodb.client.model.Filters.eq;

public class FindTest {
    public static void main(String[] args) {
        // Database클래스를 쓰는 순간 static{ }이 실행 됨. db 서버 연결, db 연결이 준비가 됨
        MongoCollection<Document> collection = Database.getCollection("todo");
        System.out.println("3. todo 컬렉션 연결 성공");

        // 전체 검색
        // FindIterable<Document> doc = collection.find();
        // 조건 검색 --> json으로 조건을 만들자(BSON)
        Bson query = eq("id", new ObjectId("6a22302eeb5a42308da310ac"));

        FindIterable<Document> doc = collection.find(query);
        System.out.println(doc);

        // FindIterable 인덱스 없으므로 반복해서 Document를 꺼내줄 수 없음
        // 외부에 반복해서 꺼내주는 반복자를 설정해야함 -> Iterator
        // 있는지 체크(hashNext())하고 있으면 꺼내줌(next())
        Iterator<Document> itr = doc.iterator();
        while (itr.hasNext()) {
            // System.out.println("==> findResultRow : " + itr.next());
            Document document = (Document) itr.next();
            System.out.println(document.get("title"));
        }
        Database.close();
    }
}
