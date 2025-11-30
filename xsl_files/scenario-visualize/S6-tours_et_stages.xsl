<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:tp="http://www.TourCyclingOperator.com/tour_packages">
	
	<!-- Cette feuille XSLT affiche la liste des clients groupés par niveau d'expérience (BEGINNER, OCCASIONAL, REGULAR, EXPERT).
Pour chaque niveau, elle liste les clients correspondants avec leur nom et email.-->
	
	
    <xsl:output method="html" encoding="UTF-8"/>
    <xsl:template match="/">
        <html>
            <head>
                <title>Circuits et étapes</title>
            </head>
            <body>
                <h2>Circuits et leurs étapes</h2>
                <xsl:for-each select="//main:tourPackage">
                    <h3><xsl:value-of select="tp:title"/></h3>
                    <ul>
                        <xsl:for-each select="//main:stage[@tourId=current()/@tourId]">
                            <li>
                                Jour <xsl:value-of select="tp:dayNumber"/> : <xsl:value-of select="tp:title"/>
                                (<xsl:value-of select="tp:distanceKm"/> km)
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:for-each>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
