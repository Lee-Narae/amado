package com.spring.app.chatting.websockethandler;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.select.Elements;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class WebCrawlerController {

    @GetMapping("/crawl.do")
    public String extractMetaContent(Model model) {
        String url = "https://shareit.kr/venue/477";  // 대상 웹페이지 URL을 입력하세요
        String metaTagSelector = "meta[itemprop=image]"; // 추출할 meta 태그의 CSS 선택자를 입력하세요
        String metaTagSelector2 = "meta[property=og:description]"; // 추출할 meta 태그의 CSS 선택자를 입력하세요
        String filePath = "C:/images/imageUrls.txt"; // 저장할 .txt 파일 경로를 입력하세요
        String filePath2 = "C:/images/textUrls.txt"; // 저장할 .txt 파일 경로를 입력하세요

        try {
            Document doc = Jsoup.connect(url).get();
            System.out.println(doc);
            // meta 태그 선택하기
            Elements metaTags = doc.select(metaTagSelector);
            Elements metaTags2 = doc.select(metaTagSelector2);

            // content 속성값 추출
            String contentValue = metaTags.attr("content");
            String contentValue2 = metaTags2.attr("content");

            // .txt 파일로 저장
            saveToTxtFile(contentValue, filePath);
            saveToTxtFile(contentValue2, filePath2);

            model.addAttribute("metaContent", contentValue);
        } catch (IOException e) {
            e.printStackTrace();
            model.addAttribute("error", "meta 태그 content 추출 중 오류 발생");
            return "error-page";
        }

        return "crawl-result";
    }

    private void saveToTxtFile(String content, String filePath) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write(content);
        } catch (IOException e) {
            e.printStackTrace();
            // 예외 처리 로직 추가
        }
    }
}