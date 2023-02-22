<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 15/02/2023
  Time: 15:44
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1"%>

<%@page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator,
                java.util.List"%>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi" %>

<%
    IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
    List<OffreEmploi> offresEmplois = serviceOffreEmploi.listeOffreEmploi();
%>

<div class="row">
    <div class="col-lg-12">
        <div class="panel panel-default">
            <div class="panel-heading"><h3><i class="fa fa-th"></i> Liste des offres emploi référencées </h3></div> <!-- /.panel-heading -->
            <div class="panel-body">
                <div class="dataTable_wrapper">
                    <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                        <!--
                          Nom des colonnes
                        -->
                        <thead>
                        <tr>
                            <th>Identifiant</th>
                            <th>Nom</th>
                            <th>Descriptif</th>
                            <th>Profile recherche</th>
                            <th>Secteur Activite</th>
                        </tr>
                        </thead>
                        <!--
                          Contenu du tableau
                        -->
                        <tbody>
                        <%
                            for(OffreEmploi offreEmploi : offresEmplois)
                            {
                        %>
                        <tr>
                            <td>OE_<%=offreEmploi.getIdOffreEmploi()%></td>
                            <td><%=offreEmploi.getNom()%></td>
                            <td><%=offreEmploi.getDescriptif()%></td>
                            <td><%=offreEmploi.getProfilRecherche()%></td>
                            <td><%=offreEmploi.getSecteurActivite()%></td>
                            <td align="center"><a href="template.jsp?action=infos_offreEmploi&id=<%=offreEmploi.getIdOffreEmploi()%>"><i class="fa fa-eye fa-lg"></i></a></td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </table>
                </div> <!-- /.table-responsive -->
            </div> <!-- /.panel-body -->
        </div> <!-- /.panel -->
    </div> <!-- /.col-lg-12 -->
</div> <!-- /.row -->
