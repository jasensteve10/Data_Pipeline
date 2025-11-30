<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:bk="http://www.TourCyclingOperator.com/bookings">

<!--  Cette feuille XSLT affiche chaque circuit (TourPackage) avec la liste de ses étapes (Stages).
Pour chaque circuit, elle affiche le titre puis les étapes avec le jour, le titre et la distance. -->


    <xsl:output method="html" indent="yes"/>

    <xsl:template match="/">
        <html>
        <head>
            <title>Réservations par statut</title>
            <meta charset="UTF-8"/>
        </head>
        <body>
            <h1>Réservations classées par statut</h1>

            <xsl:for-each select="//main:booking">
                <xsl:sort select="bk:status"/>

                <!-- Nouveau bloc de statut -->
                <xsl:if test="position() = 1 or bk:status != preceding-sibling::main:booking[1]/bk:status">
                    <h2><xsl:value-of select="bk:status"/></h2>
                </xsl:if>

                <p>
                    Booking ID :
                    <b><xsl:value-of select="@bookingId"/></b><br/>
                    Client :
                    <xsl:value-of select="@clientId"/><br/>
                    Groupe :
                    <xsl:value-of select="@tripGroupId"/><br/>
                    Total :
                    <xsl:value-of select="bk:totalPrice"/> €
                </p>

            </xsl:for-each>

        </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
