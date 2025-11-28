<!--
Cette feuille XSLT affiche la liste des réservations groupées par statut (CONFIRMED, CANCELLED, etc.).
Pour chaque statut, elle liste les réservations avec l'identifiant, le client et le montant total.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:key name="statut" match="Booking" use="status"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Réservations par statut</title>
            </head>
            <body>
                <h2>Réservations par statut</h2>
                <xsl:for-each select="//Booking[generate-id() = generate-id(key('statut', status)[1])]">
                    <h3><xsl:value-of select="status"/></h3>
                    <ul>
                        <xsl:for-each select="key('statut', status)">
                            <li>
                                Réservation <xsl:value-of select="@bookingId"/> pour client <xsl:value-of select="clientId"/>
                                (Total: <xsl:value-of select="totalPrice"/>)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
