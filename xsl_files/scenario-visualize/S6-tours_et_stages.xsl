<!--
Cette feuille XSLT affiche chaque circuit (TourPackage) avec la liste de ses étapes (Stages).
Pour chaque circuit, elle affiche le titre puis les étapes avec le jour, le titre et la distance.
-->
<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Circuits et étapes</title>
            </head>
            <body>
                <h2>Circuits et leurs étapes</h2>
                <xsl:for-each select="//TourPackage">
                    <h3><xsl:value-of select="title"/></h3>
                    <ul>
                        <xsl:for-each select="//Stage[tourId=current()/@tourId]">
                            <li>
                                Jour <xsl:value-of select="dayNumber"/> : <xsl:value-of select="title"/>
                                (<xsl:value-of select="distanceKm"/> km)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
