<?xml version="1.0" encoding="ISO-8859-1"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    
    <!-- Template racine -->
    <xsl:template match="/">
        <html>
            <head>
                <title>Clients vivant en France</title>
            </head>
            <body>
                <h2>Liste des clients dont le pays de résidence est "France"</h2>
                
                <!-- On applique les templates uniquement sur les clients français -->
                <xsl:apply-templates select="CyclingTourDatabase/Clients/Client[countryOfResidence='France']"/>
            </body>
        </html>
    </xsl:template>
    
    <!-- Template pour un Client -->
    <xsl:template match="Client">
        <div style="border:1px solid #ccc; padding:10px; margin:10px 0;">
            <!-- On affiche l'ID du client -->
            <p>
                <b>Client ID:</b>
                <span style="color:#0000ff">
                    <xsl:value-of select="@clientId"/>
                </span>
            </p>
            
            <!-- On laisse les autres infos aux templates spécifiques -->
            <xsl:apply-templates select="firstName"/>
            <xsl:apply-templates select="lastName"/>
            <xsl:apply-templates select="email"/>
            <xsl:apply-templates select="phone"/>
            <xsl:apply-templates select="countryOfResidence"/>
        </div>
    </xsl:template>
    
    <!-- Prenom -->
    <xsl:template match="firstName">
        <p><b>First name:</b> <span style="color:#ff0000"><xsl:value-of select="."/></span></p>
    </xsl:template>
    
    <!-- Nom -->
    <xsl:template match="lastName">
        <p><b>Last name:</b> <span style="color:#00aa00"><xsl:value-of select="."/></span></p>
    </xsl:template>
    
    <!-- Email -->
    <xsl:template match="email">
        <p><b>Email:</b> <span style="color:#aa00aa"><xsl:value-of select="."/></span></p>
    </xsl:template>
    
    <!-- Téléphone -->
    <xsl:template match="phone">
        <p><b>Phone:</b> <span style="color:#ff6600"><xsl:value-of select="."/></span></p>
    </xsl:template>
    
    <!-- Pays de résidence -->
    <xsl:template match="countryOfResidence">
        <p><b>Country of residence:</b> <span style="color:#000000"><xsl:value-of select="."/></span></p>
    </xsl:template>
    
</xsl:stylesheet>
