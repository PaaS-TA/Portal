package org.openpaas.paasta.portal.web.user.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletResponse;
import javax.websocket.server.PathParam;
import java.io.*;
import java.net.URI;
import java.net.URL;

/**
 *
 * @author 조민구
 * @version 1.0
 * @since 2016-09-06
 */
@Controller
public class DownloadController {
    @RequestMapping(value = {"/download/url"}, method = RequestMethod.GET)
    public void download(@PathParam("url") String url,
                         @PathParam("originalFileName") String originalFileName,
            HttpServletResponse response) throws Exception {

        // MIME Type 을 application/octet-stream 타입으로 변경
        // 무조건 팝업(다운로드창)이 뜨게 된다.
        response.setContentType("application/octet-stream");

        // 브라우저는 ISO-8859-1을 인식하기 때문에
        // UTF-8 -> ISO-8859-1로 디코딩, 인코딩 한다.
        String fileNameForBrowser = new String(originalFileName.getBytes("UTF-8"), "iso-8859-1");

        // 파일명 지정
        response.setHeader("Content-Disposition", "attachment; filename=\""+fileNameForBrowser+"\"");

        OutputStream os = response.getOutputStream();
        InputStream is = new URL(url).openStream();

        int n = 0;
        byte[] b = new byte[512];
        while((n = is.read(b)) != -1 ) {
            os.write(b, 0, n);
        }
        is.close();
        os.close();
    }
}
