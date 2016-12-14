package org.openpaas.paasta.portal.api.service;

import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

/**
 * Created by mg on 2016-07-05.
 */
public interface FileService {

    /**
     * MultipartFile을 업로드 하고 접근할 수 있는 Path를 반환한다.
     *
     * @param multipartFile
     * @return String
     */
    public String upload(MultipartFile multipartFile) throws IOException;

    /**
     * 파일을 삭제한다.
     *
     * @param fileName
     */
    public void delete(String fileName);
}
