<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:j="http:www.w3.org/2013/XSL/json" version="3.0">
    <xsl:output method="xml"/>
    
    <!-- change document name in select attribute value template below to target profile, current version -->
    <xsl:param name="j" select="unparsed-text('https://raw.githubusercontent.com/CECSpecialistI/UWLibCatProfiles/master/WAU.profile.RDA.v04.json')"/>

    <xsl:template match="/">
        <xsl:copy-of select="json-to-xml($j)"/>
    </xsl:template>

</xsl:stylesheet>
