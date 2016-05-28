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

    <xsl:template match="GlobalNamingResources[not(Environment[@name='maxExemptions'])]">
        <xsl:copy>
            <xsl:apply-templates/>
            <Environment name="maxExemptions" value="10" type="java.lang.Integer" override="false"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>