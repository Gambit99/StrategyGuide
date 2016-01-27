<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"/>
  
  <xsl:template match="/chapter">
    <html>
      <head>
		<title>
		  <xsl:value-of select="./head/title"/>
		</title>
		<style>
		p {
			text-indent:20px;
		}
		h3 {
			font-size:18pt;
			margin-bottom:0px;
			margin-top:30px;
		}
		h4 {
			margin-top:40px;
		}
		li {
			font-size:80%;
		}
		table.compare {
			font-size:75%;
		}
		</style>
		
	  	<xsl:if test="//uniticon">
			<xsl:copy-of select="document('../src/js/uniticon.js')/*" />
			<style>
			img.uniticon {
				display:inline;
				overflow:auto;
				position:relative;
				bottom:-5px;
				width: 18px;
				height: 18px;
			}
			</style>
	  	</xsl:if>
	  	
	  	<xsl:if test="//play-tip">
	  		<style>
	  		span.playtip {
	  			font-size:9pt;
	  			background-color:#f0f0a0;
	  			border: 1px;
	  			display: inline;
	  		}
	  		</style>
	  	</xsl:if>
      </head>
      <body>
        <center>
        <xsl:apply-templates select="banner"/>
        </center>
      	<table width="100%">
      	  <tr>
      	  <td width="200px">
      	  
      	  </td>
      	  <td>
	      	<h3><xsl:value-of select="head/title"/></h3>
	      	<xsl:apply-templates select="head/child::*"/><br/><br/>
      		<xsl:apply-templates select="head/following-sibling::*"/>
      	  </td>
      	  <td width="200px"/>
      	  </tr>
      	</table>
      	<br/>
      	<br/>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="section">
    <h4><xsl:value-of select="./title"/></h4>
    <xsl:apply-templates select="child::title[1]/following-sibling::*" />
  </xsl:template>
  
  <xsl:template match="author">
    <font size="-2">written by <xsl:apply-templates/><br/></font>
  </xsl:template>
  
  <xsl:template match="email">
     <a>
     <xsl:attribute name="href">
     	<xsl:value-of select="."/>
	 </xsl:attribute>
	 <small><xsl:value-of select="."/></small>
     </a>
  </xsl:template>
  
  <xsl:template match="uniticon">
     <img class="uniticon">
     	<xsl:attribute name="src">../../unitpics/<xsl:value-of select="@name"/>.png</xsl:attribute>
     </img>  
  </xsl:template>
  
  <xsl:template match="play-tip">
  	  <span class="playtip">
  	  <u>Tip:</u>
  	  <xsl:apply-templates/>
  	  </span>
  </xsl:template>
  
  <xsl:template match="unitpic">
  </xsl:template>
  
  <xsl:template match="k">
      <b>[<xsl:apply-templates select="child::node()"/>]</b>
  </xsl:template>
  
  <!-- Low-priority identity function. Didn't know you needed this explicitly! -->
  <xsl:template match="@*|node()" priority="-1">
  	<xsl:copy>
  		<xsl:apply-templates select="@*|node()"/>
  	</xsl:copy>
  </xsl:template>
  
  
</xsl:stylesheet>
