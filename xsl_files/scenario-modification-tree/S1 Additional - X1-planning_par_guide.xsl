<?xml version="1.0" encoding="UTF-8"?>
<!--
X1 - Planning par guide.
Cette feuille XSLT génère un XML regroupant, pour chaque guide,
les trip groups qu’il encadre ainsi que les réservations associées.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="xml" indent="yes"/>

    <xsl:template match="/">
        <GuideSchedules>
            <xsl:for-each select="CyclingTourDatabase/Guides/Guide">
                <Guide guideId="{@guideId}">
                    <name><xsl:value-of select="name"/></name>

                    <xsl:for-each select="/CyclingTourDatabase/TripGroups/TripGroup[leadGuideId = current()/@guideId]">
                        <TripGroup tripGroupId="{@tripGroupId}">
                            <tourId><xsl:value-of select="tourId"/></tourId>

                            <Bookings>
                                <xsl:for-each select="/CyclingTourDatabase/Bookings/Booking[tripGroupId = current()/@tripGroupId]">
                                    <Booking bookingId="{@bookingId}">
                                        <clientId><xsl:value-of select="clientId"/></clientId>
                                        <status><xsl:value-of select="status"/></status>
                                        <bookingDate><xsl:value-of select="bookingDate"/></bookingDate>
                                        <totalPrice><xsl:value-of select="totalPrice"/></totalPrice>
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
