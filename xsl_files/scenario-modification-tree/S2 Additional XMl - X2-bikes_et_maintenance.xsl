<?xml version="1.0" encoding="UTF-8"?>
<!--
X2 - Vélos et historique de maintenance.
Cette feuille XSLT génère un XML regroupant chaque vélo
avec ses logs de maintenance associés.
Entrée : tco_cycling.xml (CyclingTourDatabase)
Sortie : XML <BikeFleet>...
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <BikeFleet>
            <xsl:for-each select="CyclingTourDatabase/Bikes/Bike">
                <Bike bikeId="{@bikeId}">
                    <model><xsl:value-of select="model"/></model>
                    <frameSize><xsl:value-of select="frameSize"/></frameSize>
                    <type><xsl:value-of select="type"/></type>
                    <availability><xsl:value-of select="availability"/></availability>
                    <rentalPricePerDay><xsl:value-of select="rentalPricePerDay"/></rentalPricePerDay>

                    <maintenanceHistory>
                        <xsl:for-each select="/CyclingTourDatabase/MaintenanceLogs/MaintenanceLog[bikeId = current()/@bikeId]">
                            <MaintenanceLog logId="{@logId}">
                                <date><xsl:value-of select="date"/></date>
                                <cost><xsl:value-of select="cost"/></cost>
                                <description><xsl:value-of select="description"/></description>
                            </MaintenanceLog>
                        </xsl:for-each>
                    </maintenanceHistory>
                </Bike>
            </xsl:for-each>
        </BikeFleet>
    </xsl:template>

</xsl:stylesheet>
