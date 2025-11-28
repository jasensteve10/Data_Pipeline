
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:bk="http://www.TourCyclingOperator.com/bookings">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="statut" match="main:booking" use="bk:status"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Réservations par statut</title>
            </head>
            <body>
                <h2>Réservations par statut</h2>
                <xsl:for-each select="//main:booking[generate-id() = generate-id(key('statut', bk:status)[1])]">
                    <h3><xsl:value-of select="bk:status"/></h3>
                    <ul>
                        <xsl:for-each select="key('statut', bk:status)">
                            <li>
                                Réservation <xsl:value-of select="@bookingId"/> pour client <xsl:value-of select="@clientId"/>
                                (Total: <xsl:value-of select="bk:totalPrice"/>)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
