<?xml version="1.0" encoding="UTF-8"?>
<!--
     Cette feuille XSLT génère un XML regroupant, pour chaque guide,
     les trip groups qu’il encadre ainsi que les réservations associées.
-->
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:cg="http://www.TourCyclingOperator.com/clients_and_guides"
    xmlns:bk="http://www.TourCyclingOperator.com/bookings"
    version="1.0"
    exclude-result-prefixes="main cg bk">
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Point d'entrée : l’élément racine de la BD -->
    <xsl:template match="/main:cyclingTourDatabase">
        <GuideSchedules>
            <!-- Pour chaque guide de la base -->
            <xsl:for-each select="main:guide">
                <Guide guideId="{@guideId}">
                    <name>
                        <xsl:value-of select="cg:name"/>
                    </name>
                    
                    <!-- TripGroups encadrés par ce guide -->
                    <xsl:for-each
                        select="/main:cyclingTourDatabase/main:tripGroup[@leadGuideId = current()/@guideId]">
                        
                        <TripGroup tripGroupId="{@tripGroupId}">
                            <tourId>
                                <xsl:value-of select="@tourId"/>
                            </tourId>
                            
                            <Bookings>
                                <!-- Bookings liés à ce tripGroup -->
                                <xsl:for-each
                                    select="/main:cyclingTourDatabase/main:booking[@tripGroupId = current()/@tripGroupId]">
                                    
                                    <Booking bookingId="{@bookingId}">
                                        <clientId>
                                            <xsl:value-of select="@clientId"/>
                                        </clientId>
                                        <status>
                                            <xsl:value-of select="bk:status"/>
                                        </status>
                                        <bookingDate>
                                            <xsl:value-of select="bk:bookingDate"/>
                                        </bookingDate>
                                        <totalPrice>
                                            <xsl:value-of select="bk:totalPrice"/>
                                        </totalPrice>
                                    </Booking>
                                </xsl:for-each>
                            </Bookings>
                        </TripGroup>
                    </xsl:for-each>
                </Guide>
            </xsl:for-each>
        </GuideSchedules>
    </xsl:template>
    
</xsl:stylesheet>
