package org.openpaas.paasta.portal.api.datasource.cc;

import org.openpaas.paasta.portal.api.cloudfoundry.operations.Common;
import org.junit.Test;
import org.openpaas.paasta.portal.api.mapper.cc.SpaceMapper;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

/**
 * Created by mg on 2016-10-18.
 */
public class SpaceTest extends Common {
    @Autowired
    SpaceMapper spaceMapper;

    @Test
    public void getSpaces() {
        List<Object> s = spaceMapper.getSpacesForAdmin(53);

        s.iterator().forEachRemaining(space -> System.out.println("guid: " + space.toString()));
    }
}
