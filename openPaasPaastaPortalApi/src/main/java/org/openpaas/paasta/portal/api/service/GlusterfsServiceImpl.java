package org.openpaas.paasta.portal.api.service;

import org.javaswift.joss.model.Container;
import org.javaswift.joss.model.StoredObject;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.*;
import java.util.Base64;
import java.util.UUID;

import static org.slf4j.LoggerFactory.getLogger;

/**
 *
 * Glusterfs를 사용하기 위해 FileService 인터페이스를 구현한 클레스
 *
 * Created by mg on 2016-07-05.
 */
@Service("glusterfsService")
public class GlusterfsServiceImpl implements FileService{

    /**
     *  Glusterfs의 저장공간 Container
     */
    @Autowired
    Container container;


    /**
     *
     * MultipartFile을 업로드 하고 접근할 수 있는 Path를 반환한다.
     *
     * @param multipartFile
     * @return String
     * @throws IOException
     */
    @Override
    public String upload(MultipartFile multipartFile) throws IOException {
        String originalFilename = multipartFile.getOriginalFilename();
        String uuid = UUID.randomUUID().toString().replace("-", "");

        String filename = uuid+originalFilename.substring(originalFilename.lastIndexOf("."));

        StoredObject object = container.getObject(filename);
        object.uploadObject(multipartFile.getInputStream());

        return object.getPublicURL();
    }

    /**
     *
     * Container 안의 파일 이름으로 파일을 찾아서 삭제한다.
     * Container 경로가 포함된 완전한 Path를 주었을 경우에도 정상적으로 동작한다.
     *
     * @param objectName
     */
    // MODIFIED BY REX
    @Override
    public void delete(String objectName) {
        String containerPath = container.getPath();
        String reqObjectName = objectName;  // MODIFIED BY REX

        if (objectName.contains(containerPath)) {
            reqObjectName = objectName.substring( objectName.indexOf(containerPath) + containerPath.length()+1 );   // MODIFIED BY REX
        }

        StoredObject object  = container.getObject(reqObjectName);  // MODIFIED BY REX

        if(object.exists()) {
            object.delete();
        }
    }

    public Container getContainer() {
        return this.container;
    }

    //에러 발생
    // No serializer found for class org.javaswift.joss.command.impl.object.InputStream
    @Override
    public InputStream getBinary_input(String filePath) {
        String fileName = filePath.split("/")[6];
        StoredObject object = container.getObject(fileName);

        InputStream fileInputStream = object.downloadObjectAsInputStream();
        return fileInputStream;
    }

    @Override
    public byte[] getBinary_byte(String filePath) {
        String fileName = filePath.split("/")[6];
        StoredObject object = container.getObject(fileName);

        byte[] fileByte = object.downloadObject();

        return fileByte;
    }


}
