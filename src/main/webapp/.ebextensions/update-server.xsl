<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Apply updates to the tomcat server.xml -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="GlobalNamingResources[not(Environment[@name='apEnvironment'])]">
        <xsl:copy>
            <xsl:apply-templates/>
            <Environment name="apEnvironment" value="${{AP_ENV}}" type="java.lang.String" override="false"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="GlobalNamingResources/Environment[@name='apEnvironment']">
        <xsl:copy>
            <xsl:attribute name="name">apEnvironment</xsl:attribute>
            <xsl:attribute name="value">${AP_ENV}</xsl:attribute>
            <xsl:attribute name="type">java.lang.String</xsl:attribute>
            <xsl:attribute name="override">false</xsl:attribute>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>