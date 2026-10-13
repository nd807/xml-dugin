<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes"/>
  <xsl:key name="itemsByCity" match="item" use="@city"/>
  <xsl:key name="itemsByOrganization" match="item" use="concat(@city, '|', @org)"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8"/>
        <title>Города</title>
      </head>
      <body>
        <h1>Города и компании</h1>
        <ul>
          <xsl:for-each select="orgs/item[generate-id() = generate-id(key('itemsByCity', @city)[1])]">
            <xsl:variable name="city" select="@city"/>
            <li>
              <h3><xsl:value-of select="$city"/></h3>
              <p>Всего товаров: <xsl:value-of select="count(key('itemsByCity', $city))"/></p>
              <xsl:for-each select="key('itemsByCity', $city)[generate-id() = generate-id(key('itemsByOrganization', concat(@city, '|', @org))[1])]">
                <xsl:variable name="organizationKey" select="concat(@city, '|', @org)"/>
                <ul>
                  <li>
                    <h4><xsl:value-of select="@org"/></h4>
                    <p>Всего товаров: <xsl:value-of select="count(key('itemsByOrganization', $organizationKey))"/></p>
                    <ul>
                      <xsl:for-each select="key('itemsByOrganization', $organizationKey)">
                        <xsl:sort select="@title"/>
                        <li><xsl:value-of select="@title"/></li>
                      </xsl:for-each>
                    </ul>
                  </li>
                </ul>
              </xsl:for-each>
            </li>
          </xsl:for-each>
        </ul>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
