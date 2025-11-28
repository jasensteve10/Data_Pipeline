<?xml version="1.0" encoding="UTF-8"?>
<!--
J2 - Résumé JSON de disponibilité des vélos.
Cette feuille XSLT calcule le nombre total et le nombre de vélos disponibles
pour chaque type (TREKKING, ELECTRIC).
Entrée : tco_cycling.xml (CyclingTourDatabase)
Sortie : JSON { "bikesSummary": { ... } }
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>{&#10;  "bikesSummary": {&#10;</xsl:text>

        <!-- TREKKING -->
        <xsl:text>    "TREKKING": { "total": </xsl:text>
        <xsl:value-of select="count(CyclingTourDatabase/Bikes/Bike[type='TREKKING'])"/>
        <xsl:text>, "available": </xsl:text>
        <xsl:value-of select="count(CyclingTourDatabase/Bikes/Bike[type='TREKKING' and availability='true'])"/>
        <xsl:text> },&#10;</xsl:text>

        <!-- ELECTRIC -->
        <xsl:text>    "ELECTRIC": { "total": </xsl:text>
        <xsl:value-of select="count(CyclingTourDatabase/Bikes/Bike[type='ELECTRIC'])"/>
        <xsl:text>, "available": </xsl:text>
        <xsl:value-of select="count(CyclingTourDatabase/Bikes/Bike[type='ELECTRIC' and availability='true'])"/>
        <xsl:text> }&#10;  }&#10;}</xsl:text>
    </xsl:template>

</xsl:stylesheet>
