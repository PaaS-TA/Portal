package org.openpaas.paasta.portal.api.mapper;

import org.apache.ibatis.annotations.Param;
import org.openpaas.paasta.portal.api.config.service.surport.Portal;
import org.openpaas.paasta.portal.api.model.Catalog;

import java.util.List;

/**
 * org.openpaas.paasta.portal.api.mapper
 *
 * @author rex
 * @version 1.0
 * @since 2016.07.04
 */
@Portal
public interface CatalogMapper {

    List<Catalog> getBuildPackCatalogList(Catalog param);

    List<Catalog> getServicePackCatalogList(Catalog param);

    int getBuildPackCatalogCount(Catalog param);

    int getServicePackCatalogCount(Catalog param);

    int insertBuildPackCatalog(Catalog param);

    int insertServicePackCatalog(Catalog param);

    int updateBuildPackCatalog(Catalog param);

    int updateServicePackCatalog(Catalog param);

    int deleteBuildPackCatalog(Catalog param);

    int deleteServicePackCatalog(Catalog param);

    int getCheckDeleteBuildPackCatalogCount(Catalog param);

    int getCheckDeleteServicePackCatalogCount(Catalog param);

    int getStarterCatalogCount(Catalog param);

    List<Catalog> getStarterNamesList(Catalog param);

    List<Catalog> getBuildPackNamesList(Catalog param);

    List<Catalog> getServicePackNamesList(Catalog param);

    List<Integer> getSelectedServicePackList(Catalog param);

    Catalog getOneStarterCatalog(Catalog param);

    int getStarterCatalogMaxNumber();

    int insertStarterCatalog(Catalog param);

    int insertSelectedServicePackList(int selectedServicePackCategoryNoListValue);

    int insertSelectedServicePackListForUpdate(@Param("param") Catalog param, @Param("selectedServicePackCategoryNoListValue") int selectedServicePackCategoryNoListValue);

    int updateStarterCatalog(@Param("param") Catalog param);

    int deleteStarterCatalog(Catalog param);

    int deleteSelectedServicePackList(Catalog param);

    List<Catalog> getCatalogHistoryList(Catalog param);

    void insertCatalogHistory(Catalog param);

    List<Catalog> getCatalogStarterRelationBuildPackList(Catalog param);

    List<Catalog> getCatalogStarterRelationServicePackList(Catalog param);
}
