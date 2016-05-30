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
                <xsl:call-template name="resourceLinkApEnvironment" />
            </xsl:if>
            <xsl:if test="not(ResourceLink[@name='url'])">
                <xsl:call-template name="resourceLinkUrl" />
            </xsl:if>
            <xsl:if test="not(ResourceLink[@name='catalinaProperty'])">
                <xsl:call-template name="resourceLinkCatalinaProperty" />
            </xsl:if>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="ResourceLink[@name='apEnvironment']">
        <xsl:call-template name="resourceLinkApEnvironment" />
    </xsl:template>

    <xsl:template name="resourceLinkApEnvironment">
        <ResourceLink name="apEnvironment" global="apEnvironment" type="java.lang.String" />
    </xsl:template>

    <xsl:template match="ResourceLink[@name='url']">
        <xsl:call-template name="resourceLinkUrl" />
    </xsl:template>

    <xsl:template name="resourceLinkUrl">
        <ResourceLink name="url" global="url" type="java.lang.String" />
    </xsl:template>

    <xsl:template match="ResourceLink[@name='catalinaProperty']">
        <xsl:call-template name="resourceLinkCatalinaProperty" />
    </xsl:template>

    <xsl:template name="resourceLinkCatalinaProperty">
        <ResourceLink name="catalinaProperty" global="catalinaProperty" type="java.lang.String" />
    </xsl:template>
</xsl:stylesheet>
