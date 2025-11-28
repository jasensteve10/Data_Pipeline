<!--
Cette feuille XSLT affiche la liste des vélos disponibles à la location.
Pour chaque vélo disponible, elle affiche le modèle, la taille, le type et le prix par jour.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Vélos disponibles</title>
            </head>
            <body>
                <h2>Vélos disponibles à la location</h2>
                <ul>
                    <xsl:for-each select="//Bike[availability='true']">
                        <li>
                            <b><xsl:value-of select="model"/></b> (taille <xsl:value-of select="frameSize"/>)
                            - <xsl:value-of select="type"/> - <xsl:value-of select="rentalPricePerDay"/> €/jour
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
