<?xml version='1.0' encoding='utf-8'?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:param name="url" />

    <!-- Apply updates to the tomcat server.xml -->
    <xsl:output method="xml" indent="yes"/>
    <xsl:strip-space elements="*"/>

    <xsl:template match="@* | node()">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="GlobalNamingResources">
        <xsl:copy>
            <xsl:apply-templates select="@* | node()"/>
            <xsl:if test="not(Environment[@name='apEnvironment'])">
                <xsl:call-template name="environmentApEnvironment" />
            </xsl:if>
            <xsl:if test="not(Environment[@name='url'])">
                <xsl:call-template name="environmentUrl" />
            </xsl:if>
            <xsl:if test="not(Environment[@name='catalinaProperty'])">
                <xsl:call-template name="environmentCatalinaProperty" />
            </xsl:if>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="Environment[@name='apEnvironment']">
        <xsl:call-template name="environmentApEnvironment" />
    </xsl:template>

    <xsl:template name="environmentApEnvironment">
        <Environment name="apEnvironment" value="${{ap.env}}" type="java.lang.String" override="false"/>
    </xsl:template>

    <xsl:template match="Environment[@name='url']">
        <xsl:call-template name="environmentUrl" />
    </xsl:template>

    <xsl:template name="environmentUrl">
        <Environment name="url" value="{$url}" type="java.lang.String" override="false"/>
    </xsl:template>

    <xsl:template match="Environment[@name='catalinaProperty']">
        <xsl:call-template name="environmentCatalinaProperty" />
    </xsl:template>

    <xsl:template name="environmentCatalinaProperty">
        <Environment name="catalinaProperty" value="${{some.catalina.property}}" type="java.lang.String" override="false"/>
    </xsl:template>
</xsl:stylesheet>