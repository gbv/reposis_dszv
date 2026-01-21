<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:date="http://exslt.org/dates-and-times"
  exclude-result-prefixes="date">

  <xsl:import href="resource:xsl/layout/mir-common-layout.xsl" />

  <xsl:template name="mir.navigation">
    <div id="header_box" class="clearfix container">
      <div id="options_nav_box" class="mir-prop-nav">
        <nav>
          <ul class="navbar-nav ms-auto flex-row">
            <xsl:call-template name="mir.loginMenu" />
            <xsl:call-template name="mir.languageMenu" />
          </ul>
        </nav>
      </div>
      <div class="project-logo__box">
        <a
          href="http://dszv.it/de/"
          target="_blank"
          title="Zum Deutschen Studienzentrum Venedig">
          <img
            src="{$WebApplicationBaseURL}/images/logos/logo-dszv-jubi-336.jpg"
            class="dszv-logo"
            alt="" />
        </a>
        <div class="project-logo__slogan">
          <a
            href="{concat($WebApplicationBaseURL,substring($loaded_navigation_xml/@hrefStartingPage,2))}"
            title="Zur Startseite des Dokumentenserver"
            class="project-logo__title">
            Dokumentenserver
          </a>
          <a
            href="http://dszv.it/de/"
            target="_blank"
            title="Zum Deutschen Studienzentrum Venedig">
            <img
              src="{$WebApplicationBaseURL}/images/logos/title.gif"
              alt="" />
          </a>
        </div>
      </div>
    </div>

    <!-- Collect the nav links, forms, and other content for toggling -->
    <div class="mir-main-nav">
      <div class="container">
        <nav class="navbar navbar-expand-lg navbar-light">
          <div class="container-fluid">
            <button
              class="navbar-toggler"
              type="button"
              data-bs-toggle="collapse"
              data-bs-target="#mir-main-nav-collapse-box"
              aria-controls="mir-main-nav-collapse-box"
              aria-expanded="false"
              aria-label="Toggle navigation">
              <span class="navbar-toggler-icon"></span>
            </button>
            <div
              id="mir-main-nav-collapse-box"
              class="collapse navbar-collapse mir-main-nav__entries justify-content-between">
              <ul class="navbar-nav me-auto mt-2 mt-lg-0">
                <xsl:for-each select="$loaded_navigation_xml/menu">
                  <xsl:choose>
                    <!-- Ignore some menus, they are shown elsewhere in the layout -->
                    <xsl:when test="@id='main'" />
                    <xsl:when test="@id='brand'" />
                    <xsl:when test="@id='below'" />
                    <xsl:when test="@id='user'" />
                    <xsl:otherwise>
                      <xsl:apply-templates select="." />
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
                <xsl:call-template name="mir.basketMenu" />
              </ul>
              <form
                action="{$WebApplicationBaseURL}servlets/solr/find"
                class="searchfield_box d-flex"
                role="search">
                <!-- Check if 'initialCondQuery' exists and extract its value if it does -->
                <xsl:variable
                  name="initialCondQuery"
                  select="/response/lst[@name='responseHeader']/lst[@name='params']/str[@name='initialCondQuery']" />
                <input
                  name="condQuery"
                  placeholder="{document('i18n:mir.navsearch.placeholder')/i18n/text()}"
                  class="form-control me-sm-2 search-query"
                  id="searchInput"
                  type="text"
                  aria-label="Search" />
                <input type="hidden" id="initialCondQueryMirFlatmirLayout" name="initialCondQuery">
                  <xsl:attribute name="value">
                    <xsl:choose>
                      <xsl:when test="$initialCondQuery">
                        <xsl:value-of select="$initialCondQuery" />
                      </xsl:when>
                      <xsl:otherwise>
                        <xsl:value-of select="'*'" />
                      </xsl:otherwise>
                    </xsl:choose>
                  </xsl:attribute>
                </input>
                <xsl:choose>
                  <xsl:when test="contains($isSearchAllowedForCurrentUser, 'true')">
                    <input name="owner" type="hidden" value="createdby:*" />
                  </xsl:when>
                  <xsl:when test="not($CurrentUser='guest')">
                    <input name="owner" type="hidden" value="createdby:{$CurrentUser}" />
                  </xsl:when>
                </xsl:choose>
                <button type="submit" class="btn btn-primary my-2 my-sm-0">
                  <i class="fas fa-search"></i>
                </button>
              </form>
            </div>
          </div>
        </nav>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.jumbotwo">
    <!-- show only on startpage -->
    <xsl:if test="//div/@class='jumbotwo'">
    </xsl:if>
  </xsl:template>

  <xsl:template name="mir.footer">
    <div class="footer-menu">
      <ul class="nav">
        <li class="nav-item">
          <xsl:choose>
            <xsl:when test="$CurrentLang='it'">
              <a
                href="http://www.dszv.it/it/contatti/"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.contact')/i18n/text()" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a
                href="http://www.dszv.it/de/kontakt/"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.contact')/i18n/text()" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <li class="nav-item">
          <xsl:choose>
            <xsl:when test="$CurrentLang='it'">
              <a
                href="http://www.dszv.it/it/crediti/"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.imprint')/i18n/text()" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a
                href="http://www.dszv.it/de/impressum/"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.imprint')/i18n/text()" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </li>
        <li class="nav-item">
          <xsl:choose>
            <xsl:when test="$CurrentLang='it'">
              <a
                href="https://www.iubenda.com/privacy-policy/7992015/legal"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.privacy')/i18n/text()" />
              </a>
            </xsl:when>
            <xsl:otherwise>
              <a
                href="https://www.iubenda.com/privacy-policy/33631120/legal"
                class="nav-link">
                <xsl:value-of select="document('i18n:dszv.privacy')/i18n/text()" />
              </a>
            </xsl:otherwise>
          </xsl:choose>
        </li>
      </ul>
    </div>
    <div class="container">
      <div class="row">
        <div class="col dszv-address">
          Deutsches Studienzentrum in Venedig |
          Palazzo Barbarigo della Terrazza |
          S.Polo 2765/a Calle Corner 30125 Venezia
          <br />
          Tel. 0039 041 5206355 |
          Fax. 0039 041 5206780 |
          <a href="http://www.dszv.it/">www.dszv.it</a>
        </div>
        <div class="col-auto dszv-copyright">
          © DSZV
          <xsl:value-of select="date:year(date:date())" />
        </div>
      </div>
    </div>
  </xsl:template>

  <xsl:template name="mir.powered_by">
    <xsl:variable name="mcr_version" select="document('version:full')/version/text()" />
    <div id="powered_by">
      <a href="http://www.mycore.de">
        <img
          src="{$WebApplicationBaseURL}mir-layout/images/mycore_logo_powered_120x30_blaue_schrift_frei.png"
          title="{$mcr_version}"
          alt="powered by MyCoRe" />
      </a>
    </div>
  </xsl:template>

</xsl:stylesheet>
