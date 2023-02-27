<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 27/02/2023
  Time: 11:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Entreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.Utils" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.SecteurActivite" %>
<%@ page import="static jdk.internal.org.jline.reader.impl.LineReaderImpl.CompletionType.List" %>
<%@ page import="static java.lang.invoke.VarHandle.AccessMode.SET" %>
<%@ page import="java.util.Set" %>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>
<%@ page errorPage="/erreur.jsp" %>
<%
    String action = request.getParameter("action");
    if (action == null || action.equals(""))
        action = "accueil.jsp";
    else
        action = action + ".jsp";
%>

<!DOCTYPE html>
<html lang="en">
<jsp:include page="fragments/head.html"/>
<body>
<div id="wrapper">
    <!-- Navigation -->
    <nav class="navbar
                  navbar-default
                  navbar-static-top"
         role="navigation"
         style="margin-bottom: 0">
        <jsp:include page="fragments/bandeau.jsp"/>
        <jsp:include page="fragments/menu.jsp"/>
    </nav>
    <div id="page-wrapper">
        <%
            Candidat candidat = (Candidat) session.getAttribute("candidat");
        %>
        <div class="col-lg-offset-2 col-lg-8
                          col-xs-12">
            <div class="panel panel-success">
                <div class="panel-heading">
                    Mon profil
                </div>
                <div class="panel-body">
                    <small>
                        <table class="table">
                            <tbody>
                            <tr class="success">
                                <td><strong>Identifiant (login)</strong></td>
                                <td>ENT_<%=candidat.getIdCandidat()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Nom</strong></td>
                                <td><%=candidat.getNom()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Prenom</strong></td>
                                <td><%=candidat.getPrenom()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Date Naissance</strong></td>
                                <td><%=candidat.getDateNaissance().toString()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Adresse postale (ville)</strong></td>
                                <td><%=candidat.getAdressePostale()%>
                                </td>
                            </tr>
                            <tr class="warning">
                                <td><strong>Mail</strong></td>
                                <td><%=Utils.text2HTML(candidat.getAdresseEmail())%>
                                </td>
                            </tr>

                            <tr class="warning">
                                <td><strong>CV</strong></td>
                                <td><%=candidat.getCv()%>
                                </td>
                            </tr>
                            </tbody>
                        </table>
                    </small>
                </div>
            </div>
        </div>
    </div> <!-- /#page-wrapper -->
</div> <!-- /#wrapper -->
<jsp:include page="fragments/fin_de_page.html"/>
</body>
</html>
