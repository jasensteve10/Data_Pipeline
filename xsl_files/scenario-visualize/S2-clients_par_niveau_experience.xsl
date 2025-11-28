<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:main="http://www.TourCyclingOperator.com/main">

    <xsl:output method="html" encoding="UTF-8"/>

    <!--
        Clé de groupement : on groupe les cg:client
        par valeur de cg:experienceLevel
    -->
    <xsl:key
        name="exp"
        match="Client"
        use="normalize-space(experienceLevel)"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Clients par niveau d'expérience</title>
            </head>
            <body>
                <h2>Clients par niveau d'expérience</h2>

                <!--
                    Pour chaque niveau distinct :
                    on prend le premier client de chaque groupe.
                -->
                <xsl:for-each
                    select="//Client
                            [generate-id()
                             = generate-id(
                                   key('exp',
                                       normalize-space(experienceLevel)
                                   )[1]
                               )]">

                    <!-- Titre du groupe = niveau d'expérience -->
                    <h3>
                        <xsl:value-of select="experienceLevel"/>
                    </h3>

                    <ul>
                        <!-- Tous les clients avec ce niveau -->
                        <xsl:for-each
                            select="key('exp',
                                        normalize-space(experienceLevel))">
                            <li>
                                <xsl:value-of select="firstName"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="lastName"/>
                                <xsl:text> (</xsl:text>
                                <xsl:value-of select="email"/>
                                <xsl:text>)</xsl:text>
                            </li>
                        </xsl:for-each>
                    </ul>

                </xsl:for-each>
            </body>
        </html>
    </xsl:template>

</xsl:stylesheet>
