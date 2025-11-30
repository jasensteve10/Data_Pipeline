<?xml version="1.0" encoding="UTF-8"?>
<!--
X2 - Vélos et historique de maintenance (compatible namespaces).
Cette feuille XSLT génère un XML regroupant chaque vélo
avec ses logs de maintenance associés.
Entrée : main:cyclingTourDatabase, main:bike, main:maintenanceLog
Sortie : <BikeFleet>...</BikeFleet>
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:b="http://www.TourCyclingOperator.com/bike_fleet_and_maintenance"
    version="1.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <BikeFleet>
            <xsl:for-each select="/main:cyclingTourDatabase/main:bike">
                <Bike bikeId="{@bikeId}">
                    <model><xsl:value-of select="b:model"/></model>
                    <frameSize><xsl:value-of select="b:frameSize"/></frameSize>
                    <type><xsl:value-of select="b:type"/></type>
                    <availability><xsl:value-of select="b:availability"/></availability>
                    <rentalPricePerDay><xsl:value-of select="b:rentalPricePerDay"/></rentalPricePerDay>

                    <maintenanceHistory>
                        <xsl:for-each select="/main:cyclingTourDatabase/main:maintenanceLog[@bikeId = current()/@bikeId]">
                            <MaintenanceLog logId="{@logId}">
                                <date><xsl:value-of select="b:date"/></date>
                                <cost><xsl:value-of select="b:cost"/></cost>
                                <description><xsl:value-of select="b:description"/></description>
                            </MaintenanceLog>
                        </xsl:for-each>
                    </maintenanceHistory>
                </Bike>
            </xsl:for-each>
        </BikeFleet>
    </xsl:template>

</xsl:stylesheet>
