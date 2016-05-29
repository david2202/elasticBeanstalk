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

    <xsl:template match="Context[not(ResourceLink[@name='apEnvironment'])]">
        <xsl:copy>
            <xsl:apply-templates/>
            <ResourceLink name="apEnvironment" global="apEnvironment" type="java.lang.String" />
        </xsl:copy>
    </xsl:template>
    <xsl:template match="Context/ResourceLink[@name='apEnvironment']">
        <xsl:copy>
            <xsl:attribute name="name">apEnvironment</xsl:attribute>
            <xsl:attribute name="global">apEnvironment</xsl:attribute>
            <xsl:attribute name="type">java.lang.String</xsl:attribute>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>