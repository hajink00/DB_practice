package app;

import com.mongodb.client.MongoClient;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoDatabase;

public class ConnectionTest {
    public static void main(String[] args) {
        String uri = "mongodb://127.0.0.1:27017";
        String db = "todo_db";

        // 몽고db와 java 연동
        // 몽고db 연동할 수 있는 자바 라이브러리 필요
        // 몽고db driver 필요
        // 1. 몽고db 서버 연결 --> 외부자원(네트워크) 연결은 반드시 예외 처리
        // try-catch-resources
        // 2. 몽고db 서버의 db 연결
        // 3. 몽고db 연결된 db의 collection 연결
        // 4. collection의 document(json) crud
        // 5. 몽고db close

        try (MongoClient mongoClient = MongoClients.create(uri)) {
            MongoDatabase database = mongoClient.getDatabase(db);
            System.out.println("1. 몽고DB 서버 연결 성공 " );
            System.out.println("2. 몽고DB 연결(todo_db 성공 " + database);
        } catch (Exception e) {
            System.out.println("몽고DB 연결시 에러 발생 " + e.getMessage());
        }

    }
}
