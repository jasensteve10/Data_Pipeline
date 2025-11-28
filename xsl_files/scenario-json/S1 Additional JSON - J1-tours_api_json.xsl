<?xml version="1.0" encoding="UTF-8"?>
<!--
J1 - Tours en format JSON.
Cette feuille XSLT génère un JSON contenant chaque tour
ainsi que la liste de ses étapes.
Entrée : tco_cycling.xml (CyclingTourDatabase)
Sortie : JSON { "tours": [...] }
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>{&#10;  "tours": [&#10;</xsl:text>

        <xsl:for-each select="CyclingTourDatabase/TourPackages/TourPackage">
            <xsl:text>    {&#10;</xsl:text>
            <xsl:text>      "tourId": "</xsl:text><xsl:value-of select="@tourId"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "title": "</xsl:text><xsl:value-of select="title"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "totalDurationDays": </xsl:text><xsl:value-of select="totalDurationDays"/><xsl:text>,&#10;</xsl:text>
            <xsl:text>      "difficulty": "</xsl:text><xsl:value-of select="difficulty"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "stages": [&#10;</xsl:text>

            <xsl:variable name="tourId" select="@tourId"/>

            <xsl:for-each select="/CyclingTourDatabase/Stages/Stage[tourId = $tourId]">
                <xsl:text>        { "stageId": "</xsl:text><xsl:value-of select="@stageId"/><xsl:text>", </xsl:text>
                <xsl:text>"dayNumber": </xsl:text><xsl:value-of select="dayNumber"/><xsl:text>, </xsl:text>
                <xsl:text>"title": "</xsl:text><xsl:value-of select="title"/><xsl:text>", </xsl:text>
                <xsl:text>"distanceKm": </xsl:text><xsl:value-of select="distanceKm"/><xsl:text> }</xsl:text>

                <xsl:if test="position() != last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>

            <xsl:text>      ]&#10;    }</xsl:text>

            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>

            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>

        <xsl:text>  ]&#10;}</xsl:text>
    </xsl:template>

</xsl:stylesheet>
