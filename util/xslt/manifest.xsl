<?xml version="1.0" encoding="UTF-8" ?>
<xsl:transform version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:param name="bookTitle"/>
<xsl:param name="bookId"/>
<xsl:output method="html" indent="no"/>
	<xsl:template match="/">
		<xsl:text disable-output-escaping='yes'>&lt;!doctype html&gt;</xsl:text>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="bookdata">
		<xsl:element name="html">
			<xsl:attribute name="lang">ru</xsl:attribute>
			<!-- TODO: replace with <xsl:value-of select="@lang"/> -->
			<head>
			<xsl:element name="title">
				<xsl:value-of select="$bookTitle"/>
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
	<xsl:template match="head">
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="manifest">
		<xsl:text disable-output-escaping='yes'>&lt;hr&gt;</xsl:text>
		<ul>
		<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="meta">
		<xsl:if test="@name = 'title'">
			<h2 class="booktitle"><xsl:value-of select="@content"/></h2>
		</xsl:if>
		<xsl:if test="@name = 'publisher'">
			<p class="bookdata"><xsl:value-of select="@content"/></p>
		</xsl:if>
		<xsl:if test="@name = 'year'">
			<p class="bookinfo">Год издания: <xsl:value-of select="@content"/></p>
		</xsl:if>
		<xsl:if test="@name = 'note'">
			<p class="bookinfo"><xsl:value-of select="@content"/></p>
			<p class="bookinfo">
				<xsl:element name="a">
					<xsl:attribute name="href">http://www.ponomar.net/cgi-bin/bookpage.cgi?id=<xsl:value-of select="$bookId"/>&amp;page=1</xsl:attribute>
					<xsl:attribute name="target">_blank</xsl:attribute>
					Просмотр страниц &gt;
				</xsl:element>
			</p>
		</xsl:if>
	</xsl:template>
	<xsl:template match="chapter">
		<li class="bookdata">
		<xsl:element name="a">
			<xsl:attribute name="href">chapters/<xsl:value-of select="@file"/></xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="@name"/></xsl:attribute>
			<xsl:value-of select="@name"/>
		</xsl:element>
		</li>
	</xsl:template>
</xsl:transform>
