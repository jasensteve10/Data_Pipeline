<?xml version="1.0" encoding="UTF-8"?>
<!--
J1 - Tours en format JSON (compatible namespaces).
Cette feuille XSLT génère un JSON contenant chaque tour
ainsi que la liste de ses étapes.
Entrée : main:cyclingTourDatabase (avec namespaces main: et tp:)
Sortie : JSON { "tours": [...] }
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages"
    version="1.0">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>{&#10;  "tours": [&#10;</xsl:text>

        <!-- Parcours de tous les tourPackage -->
        <xsl:for-each select="/main:cyclingTourDatabase/main:tourPackage">
            <xsl:text>    {&#10;</xsl:text>
            <xsl:text>      "tourId": "</xsl:text><xsl:value-of select="@tourId"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "title": "</xsl:text><xsl:value-of select="tp:title"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "totalDurationDays": </xsl:text><xsl:value-of select="tp:totalDurationDays"/><xsl:text>,&#10;</xsl:text>
            <xsl:text>      "difficulty": "</xsl:text><xsl:value-of select="tp:difficulty"/><xsl:text>",&#10;</xsl:text>
            <xsl:text>      "stages": [&#10;</xsl:text>

            <!-- On mémorise l'id du tour courant -->
            <xsl:variable name="tourId" select="@tourId"/>

            <!-- On parcourt toutes les étapes liées à ce tour -->
            <xsl:for-each select="/main:cyclingTourDatabase/main:stage[@tourId = $tourId]">
                <xsl:text>        { "stageId": "</xsl:text><xsl:value-of select="@stageId"/><xsl:text>", </xsl:text>
                <xsl:text>"dayNumber": </xsl:text><xsl:value-of select="tp:dayNumber"/><xsl:text>, </xsl:text>
                <xsl:text>"title": "</xsl:text><xsl:value-of select="tp:title"/><xsl:text>", </xsl:text>
                <xsl:text>"distanceKm": </xsl:text><xsl:value-of select="tp:distanceKm"/><xsl:text> }</xsl:text>

                <!-- Virgule entre les objets de stages -->
                <xsl:if test="position() != last()">
                    <xsl:text>,</xsl:text>
                </xsl:if>
                <xsl:text>&#10;</xsl:text>
            </xsl:for-each>

            <xsl:text>      ]&#10;    }</xsl:text>

            <!-- Virgule entre les tours -->
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
            <xsl:text>&#10;</xsl:text>
        </xsl:for-each>

        <xsl:text>  ]&#10;}</xsl:text>
    </xsl:template>

</xsl:stylesheet>
