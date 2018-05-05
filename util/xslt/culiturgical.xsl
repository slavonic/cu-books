<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:cu="http://www.ponomar.net/culiturgical">
<xsl:param name="fileTitle"/>
<xsl:param name="bookId"/>
<xsl:output method="html" indent="no"/>
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;</xsl:text>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="cu:document">
		<xsl:element name="html">
			<xsl:attribute name="lang"><xsl:value-of select="@lang"/></xsl:attribute>
			<head>
			<xsl:element name="title">
				<xsl:value-of select="$fileTitle"/>
			</xsl:element>
			<xsl:element name="meta">
				<xsl:attribute name="charset">utf-8</xsl:attribute>
			</xsl:element>
			<xsl:element name="link">
				<xsl:attribute name="rel">stylesheet</xsl:attribute>
				<xsl:attribute name="href">util/css/culiturgical.css</xsl:attribute>
			</xsl:element>
			</head>
			<body>
			<xsl:apply-templates/>
			</body>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:p">
		<xsl:choose>
			<xsl:when test="@lang">
				<xsl:element name="p">
					<!-- lang of p is defined -->
					<xsl:attribute name="class"><xsl:value-of select="@lang"/>-text</xsl:attribute>
					<xsl:apply-templates/>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="p">
					<!-- inherit language from document if lang of p is not defined -->
					<xsl:attribute name="class"><xsl:value-of select="../@lang"/>-text</xsl:attribute><xsl:apply-templates/>
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template match="cu:red">
		<xsl:element name="span">
			<xsl:attribute name="class">red</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:wide">
		<xsl:element name="span">
			<xsl:attribute name="class">wide</xsl:attribute>
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:small">
		<xsl:element name="small">
			<xsl:value-of select="."/>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:anchor">
		<xsl:element name="small">
			<xsl:attribute name="class">pb</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="title">
					<xsl:value-of select="@type"/>
					<xsl:text> </xsl:text>
					<xsl:value-of select="@number"/>
				</xsl:attribute>
				<xsl:attribute name="href">http://www.ponomar.net/cgi-bin/bookpage.cgi?id=<xsl:value-of select="$bookId"/>&amp;page=<xsl:value-of select="@number"/></xsl:attribute>
				<xsl:value-of select="@number"/>
			</xsl:element>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:footnote">
		<xsl:variable name="footnoteNumber">
			<xsl:number />
		</xsl:variable>
		<xsl:element name="sup">[<xsl:element name="a">
			<xsl:attribute name="href">
				#fn<xsl:value-of select="$footnoteNumber" />
			</xsl:attribute>
			<xsl:attribute name="name">
				fr<xsl:value-of select="$footnoteNumber"/>
			</xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="."/>
			</xsl:attribute><xsl:value-of select="$footnoteNumber" />
		</xsl:element>]</xsl:element>
	</xsl:template>
	<xsl:template match="cu:footer">
		<xsl:element name="p">
		<xsl:attribute name="class">ru-text</xsl:attribute>
		<xsl:for-each select="//footnote">
			<xsl:variable name="footnoteNumber">
				<xsl:number />
			</xsl:variable>
			[<xsl:element name="a">
				<xsl:attribute name="name">
				fn<xsl:value-of select="$footnoteNumber" />
				</xsl:attribute>
				<xsl:attribute name="href">
				#fr<xsl:value-of select="$footnoteNumber" />
				</xsl:attribute>
				<xsl:value-of select="$footnoteNumber" />
			</xsl:element>] <xsl:apply-templates select="." mode="footer" />
			<br/>
		</xsl:for-each>
		</xsl:element>
	</xsl:template>
	<xsl:template match="cu:footnote" mode="footer">
		<xsl:choose>
			<xsl:when test="@lang">
				<xsl:element name="span">
					<!-- lang of footnote is defined -->
					<xsl:attribute name="class"><xsl:value-of select="@lang"/>-text</xsl:attribute>
					<xsl:apply-templates select="." mode="footnote" />
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:element name="span">
					<!-- inherit language from document if lang of footnote is not defined -->
					<xsl:attribute name="class"><xsl:value-of select="../../@lang"/>-text</xsl:attribute>
					<xsl:apply-templates select="." mode="footnote" />
				</xsl:element>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:transform>
