<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" exclude-result-prefixes="xs math"
    version="3.0">

    <!-- Keys -->
    <xsl:key name="rdaW" match="rdf:Description" use="tokenize(@rdf:about, '/')[last()]"/>
    <xsl:key name="rdaE" match="rdf:Description" use="tokenize(@rdf:about, '/')[last()]"/>
    <xsl:key name="rdaM" match="rdf:Description" use="tokenize(@rdf:about, '/')[last()]"/>
    <xsl:key name="rdaMDt" match="rdf:Description" use="tokenize(@rdf:about, '/')[last()]"/>
    <xsl:key name="rdaI" match="rdf:Description" use="tokenize(@rdf:about, '/')[last()]"/>
    <xsl:key name="uwRdaExt" match="rdf:Description" use="tokenize(@rdf:about, '#')[last()]"/>
    <!-- Key variables -->
    <xsl:variable name="rdaWXml"
        select="document('https://raw.githubusercontent.com/RDARegistry/RDA-Vocabularies/master/xml/Elements/w.xml')"/>
    <xsl:variable name="rdaEXml"
        select="document('https://raw.githubusercontent.com/RDARegistry/RDA-Vocabularies/master/xml/Elements/e.xml')"/>
    <xsl:variable name="rdaMXml"
        select="document('https://raw.githubusercontent.com/RDARegistry/RDA-Vocabularies/master/xml/Elements/m.xml')"/>
    <xsl:variable name="rdaMDtXml"
        select="document('https://raw.githubusercontent.com/RDARegistry/RDA-Vocabularies/master/xml/Elements/m/datatype.xml')"/>
    <xsl:variable name="rdaIXml"
        select="document('https://raw.githubusercontent.com/RDARegistry/RDA-Vocabularies/master/xml/Elements/i.xml')"/>
    <xsl:variable name="uwRdaExtXml"
        select="document('https://www.lib.washington.edu/static/public/cams/data/localResources/rdaApplicationProfileExtension-1-0-1.rdf')"/>
    <!-- Other var -->
    <xsl:variable name="break2">
        <strong>
            <xsl:text>  |  </xsl:text>
        </strong>
    </xsl:variable>

    <xsl:template name="property">
        <xsl:param name="p"/>
        <!-- TO DO add additional namespace keys, source document vars (above) choose > fn:keys (here) -->
        <xsl:choose>
            <xsl:when test="key('rdaW', local-name(.), $rdaWXml)">
                <a href="{key('rdaW', local-name(.), $rdaWXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('rdaW', local-name(.), $rdaWXml)/rdfs:label[@xml:lang = 'en']"/>
                </a>
            </xsl:when>
            <xsl:when test="key('rdaE', local-name(.), $rdaEXml)">
                <a href="{key('rdaE', local-name(.), $rdaEXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('rdaE', local-name(.), $rdaEXml)/rdfs:label[@xml:lang = 'en']"/>
                </a>
            </xsl:when>
            <xsl:when test="key('rdaM', local-name(.), $rdaMXml)">
                <a href="{key('rdaM', local-name(.), $rdaMXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('rdaM', local-name(.), $rdaMXml)/rdfs:label[@xml:lang = 'en']"/>
                </a>
            </xsl:when>
            <xsl:when test="key('rdaMDt', local-name(.), $rdaMDtXml)">
                <a href="{key('rdaMDt', local-name(.), $rdaMDtXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('rdaMDt', local-name(.), $rdaMDtXml)/rdfs:label[@xml:lang = 'en']"
                    />
                </a>
            </xsl:when>
            <xsl:when test="key('rdaI', local-name(.), $rdaIXml)">
                <a href="{key('rdaI', local-name(.), $rdaIXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('rdaI', local-name(.), $rdaIXml)/rdfs:label[@xml:lang = 'en']"/>
                </a>
            </xsl:when>
            <xsl:when test="key('uwRdaExt', local-name(.), $uwRdaExtXml)">
                <a href="{key('uwRdaExt', local-name(.), $uwRdaExtXml)/@rdf:about}">
                    <xsl:value-of
                        select="key('uwRdaExt', local-name(.), $uwRdaExtXml)/rdfs:label[@xml:lang = 'en']"
                    />
                </a>
            </xsl:when>
            <xsl:otherwise>
                <a href=".">
                    <xsl:value-of select="local-name(.)"/>
                </a>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="val_resource">
        <!-- BIG QUESTION / TO DO:
                        Get any associated rdfs:label values for resources -->
        <xsl:param name="r"/>
        <a href="{$r}">
            <xsl:value-of select="$r"/>
        </a>
        <!-- <xsl:value-of select="$break2"/>
        <span name="resourceLabel">
            <xsl:value-of select="rdf:Description[@rdf:about = $r]/rdfs:label"/>
        </span> -->
    </xsl:template>
    <xsl:template name="val_literal">
        <xsl:param name="l"/>
        <span class="literals">
            <xsl:value-of select="."/>
        </span>
        <xsl:value-of select="$break2"/>
        <xsl:choose>
            <!-- This assumes NO EMPTY LANG ATTRIBUTES -->
            <xsl:when test=".[@xml:lang]">
                <span class="langTags">
                    <xsl:text>"</xsl:text>
                    <xsl:value-of select="@xml:lang"/>
                    <xsl:text>"</xsl:text>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="langTags">
                    <xsl:text>No language tag</xsl:text>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    <xsl:template name="val_bnode"/>
</xsl:stylesheet>