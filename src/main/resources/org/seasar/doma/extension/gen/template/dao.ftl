<#-- このテンプレートに対応するデータモデルのクラスは org.seasar.doma.extension.gen.DaoDesc です -->
<#import "/lib.ftl" as lib>
<#if lib.copyright??>
${lib.copyright}
</#if>
<#if packageName??>
package ${packageName};
</#if>

<#list importNames as importName>
import ${importName};
</#list>

/**
<#if lib.author??>
 * @author ${lib.author}
</#if>
 */
@Dao<#if configClassSimpleName??>(config = ${configClassSimpleName}.class)</#if>
public interface ${simpleName} {

<#if entityDesc.idEntityPropertyDescs?size gt 0>
    /**
<#list entityDesc.idEntityPropertyDescs as property>
     * @param ${property.name}
</#list>
     * @return the <#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} entity
     */
    @Select
    <#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} selectById(<#list entityDesc.idEntityPropertyDescs as property>${property.propertyClassSimpleName} ${property.name}<#if property_has_next>, </#if></#list>);

</#if>
<#if entityDesc.idEntityPropertyDescs?size gt 0 && entityDesc.versionEntityPropertyDesc??>
    /**
<#list entityDesc.idEntityPropertyDescs as property>
     * @param ${property.name}
</#list>
     * @param ${entityDesc.versionEntityPropertyDesc.name}
     * @return the <#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} entity
     */
    @Select(ensureResult = true)
    <#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} selectByIdAndVersion(<#list entityDesc.idEntityPropertyDescs as property>${property.propertyClassSimpleName} ${property.name}, </#list>${entityDesc.versionEntityPropertyDesc.propertyClassSimpleName} ${entityDesc.versionEntityPropertyDesc.name});

</#if>
    /**
     * @param entity
     * @return affected rows
     */
    @Insert
    int insert(<#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} entity);

    /**
     * @param entity
     * @return affected rows
     */
    @Update
    int update(<#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} entity);

    /**
     * @param entity
     * @return affected rows
     */
    @Delete
    int delete(<#if entityDesc.entityPrefix??>${entityDesc.entityPrefix}</#if>${entityDesc.simpleName} entity);
}