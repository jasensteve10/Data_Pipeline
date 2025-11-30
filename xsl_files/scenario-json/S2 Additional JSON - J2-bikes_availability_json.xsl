<?xml version="1.0" encoding="UTF-8"?>
<!--
J2 - Résumé JSON de disponibilité des vélos (version namespace).
Compatible avec XML utilisant main: et b: namespaces.
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:b="http://www.TourCyclingOperator.com/bike_fleet_and_maintenance"
    version="1.0">

    <xsl:output method="text" encoding="UTF-8"/>

    <xsl:template match="/">
        <xsl:text>{&#10;  "bikesSummary": {&#10;</xsl:text>

        <!-- TREKKING -->
        <xsl:text>    "TREKKING": { "total": </xsl:text>
        <xsl:value-of select="count(//main:bike[b:type='TREKKING'])"/>
        <xsl:text>, "available": </xsl:text>
        <xsl:value-of select="count(//main:bike[b:type='TREKKING' and b:availability='true'])"/>
        <xsl:text> },&#10;</xsl:text>

        <!-- ELECTRIC -->
        <xsl:text>    "ELECTRIC": { "total": </xsl:text>
        <xsl:value-of select="count(//main:bike[b:type='ELECTRIC'])"/>
        <xsl:text>, "available": </xsl:text>
        <xsl:value-of select="count(//main:bike[b:type='ELECTRIC' and b:availability='true'])"/>
        <xsl:text> }&#10;  }&#10;}</xsl:text>

    </xsl:template>
</xsl:stylesheet>
