<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main"
    xmlns:b="http://www.TourCyclingOperator.com/bike_fleet_and_maintenance">

    <xsl:output method="html" encoding="UTF-8"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Vélos disponibles</title>
            </head>
            <body>
                <h2>Vélos disponibles à la location</h2>
                <ul>
                    <!--
                        On sélectionne tous les vélos (main:bike)
                        dont b:availability = 'true'
                    -->
                    <xsl:for-each select="//main:bike[b:availability = 'true']">
                        <!-- option : trier par modèle -->
                        <xsl:sort select="b:model"/>

                        <li>
                            <b>
                                <xsl:value-of select="b:model"/>
                            </b>
                            <xsl:text> (taille </xsl:text>
                            <xsl:value-of select="b:frameSize"/>
                            <xsl:text>) - </xsl:text>

                            <xsl:value-of select="b:type"/>
                            <xsl:text> - </xsl:text>
                            <xsl:value-of select="b:rentalPricePerDay"/>
                            <xsl:text> €/jour</xsl:text>
                        </li>
                    </xsl:for-each>
                </ul>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
