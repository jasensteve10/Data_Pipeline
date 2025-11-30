<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:cg="http://www.TourCyclingOperator.com/clients_and_guides"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages"
    xmlns:bk="http://www.TourCyclingOperator.com/bookings"
    exclude-result-prefixes="main cg tp bk">
	
	<!-- listing all bookings with resolved client info and tour info -->
    
    <xsl:output method="xml" indent="yes" encoding="UTF-8"/>
    
    <!-- Find client element from a clientId -->
    <xsl:key name="clientById" match="main:client" use="@clientId"/>
    
    <!-- Find tourPackage element from a tourId -->
    <xsl:key name="tourById" match="main:tourPackage" use="@tourId"/>
    
    <!-- ========= creating new ROOT TEMPLATE ========= -->
    <!-- Match the root element of your database -->
    <xsl:template match="/main:cyclingTourDatabase">
        <bookingReport>
            <!-- Apply templates only on bookings -->
            <xsl:apply-templates select="main:booking"/>
        </bookingReport>
    </xsl:template>
    
    <!-- ========= creating new attribute from the old example ========= -->
    <xsl:template match="main:booking">
        <bookingSummary>
            <!-- Copy some IDs as attributes in the new XML -->
            <xsl:attribute name="bookingId">
                <xsl:value-of select="@bookingId"/>
            </xsl:attribute>
            <xsl:attribute name="clientId">
                <xsl:value-of select="@clientId"/>
            </xsl:attribute>
            <xsl:attribute name="tripGroupId">
                <xsl:value-of select="@tripGroupId"/>
            </xsl:attribute>
            <xsl:attribute name="tourId">
                <xsl:value-of select="@tourId"/>
            </xsl:attribute>
            
            <!-- getting the info from the old database -->
            <bookingDate>
                <xsl:value-of select="bk:bookingDate"/>
            </bookingDate>
            <status>
                <xsl:value-of select="bk:status"/>
            </status>
            <totalPrice>
                <xsl:value-of select="bk:totalPrice"/>
            </totalPrice>
            
            <!-- ========= getting and creating client info ========= -->
            <client>
                <!-- Look up the client element with the key -->
                <xsl:variable name="client" select="key('clientById', @clientId)"/>
                
                <name>
                    <xsl:value-of select="concat($client/cg:firstName, ' ', $client/cg:lastName)"/>
                </name>
                <country>
                    <xsl:value-of select="$client/cg:countryOfResidence"/>
                </country>
                <experienceLevel>
                    <xsl:value-of select="$client/cg:experienceLevel"/>
                </experienceLevel>
            </client>
            
            <!-- ========= getting and creating the tour info ========= -->
            <tour>
                <xsl:variable name="tour" select="key('tourById', @tourId)"/>
                
                <title>
                    <xsl:value-of select="$tour/tp:title"/>
                </title>
                <difficulty>
                    <xsl:value-of select="$tour/tp:difficulty"/>
                </difficulty>
                <currency>
                    <xsl:value-of select="$tour/tp:currency"/>
                </currency>
                <totalDurationDays>
                    <xsl:value-of select="$tour/tp:totalDurationDays"/>
                </totalDurationDays>
            </tour>
        </bookingSummary>
    </xsl:template>
    
</xsl:stylesheet>
