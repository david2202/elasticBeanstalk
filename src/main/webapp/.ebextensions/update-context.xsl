<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!-- Apply updates to the tomcat context.xml -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="Context">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:if test="not(ResourceLink[@name='apEnvironment'])">
                <ResourceLink name="apEnvironment" global="apEnvironment" type="java.lang.String" />
            </xsl:if>
            <xsl:if test="not(ResourceLink[@name='url'])">
                <ResourceLink name="url" global="url" type="java.lang.String" />
            </xsl:if>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ResourceLink[@name='apEnvironment']">
        <xsl:copy>
            <xsl:attribute name="name">apEnvironment</xsl:attribute>
            <xsl:attribute name="global">apEnvironment</xsl:attribute>
            <xsl:attribute name="type">java.lang.String</xsl:attribute>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="ResourceLink[@name='url']">
        <xsl:copy>
            <xsl:attribute name="name">url</xsl:attribute>
            <xsl:attribute name="global">url</xsl:attribute>
            <xsl:attribute name="type">java.lang.String</xsl:attribute>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
