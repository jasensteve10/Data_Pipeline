<?xml version="1.0" encoding="UTF-8"?>
<!--
X1 - Planning par guide (compatible namespaces).
Cette feuille XSLT génère un XML regroupant, pour chaque guide,
les tripGroups qu’il encadre ainsi que les bookings associés.
Entrée : main:cyclingTourDatabase
Sortie : <GuideSchedules>...</GuideSchedules>
-->
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:cg="http://www.TourCyclingOperator.com/clients_and_guides"
    xmlns:bk="http://www.TourCyclingOperator.com/bookings"
    version="1.0">

    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <GuideSchedules>
            <!-- Parcours de tous les guides -->
            <xsl:for-each select="/main:cyclingTourDatabase/main:guide">
                <Guide guideId="{@guideId}">
                    <name><xsl:value-of select="cg:name"/></name>

                    <!-- TripGroups menés par ce guide -->
                    <xsl:for-each select="/main:cyclingTourDatabase/main:tripGroup[@leadGuideId = current()/@guideId]">
                        <TripGroup tripGroupId="{@tripGroupId}">
                            <tourId><xsl:value-of select="@tourId"/></tourId>

                            <!-- Bookings sur ce TripGroup -->
                            <Bookings>
                                <xsl:for-each select="/main:cyclingTourDatabase/main:booking[@tripGroupId = current()/@tripGroupId]">
                                    <Booking bookingId="{@bookingId}">
                                        <clientId><xsl:value-of select="@clientId"/></clientId>
                                        <status><xsl:value-of select="bk:status"/></status>
                                        <bookingDate><xsl:value-of select="bk:bookingDate"/></bookingDate>
                                        <totalPrice><xsl:value-of select="bk:totalPrice"/></totalPrice>
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
