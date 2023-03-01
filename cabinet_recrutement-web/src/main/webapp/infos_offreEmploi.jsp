<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 27/02/2023
  Time: 17:17
  To change this template use File | Settings | File Templates.
--%>
<%--
  Created by IntelliJ IDEA.
  User: mathieu
  Date: 24/02/2023
  Time: 10:51
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html" pageEncoding="ISO-8859-1" %>

<%@ page import="eu.telecom_bretagne.cabinet_recrutement.front.utils.ServicesLocator" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceCandidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.Candidat" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceOffreEmploi" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.service.IServiceEntreprise" %>
<%@ page import="eu.telecom_bretagne.cabinet_recrutement.data.model.OffreEmploi" %>
<%
  IServiceOffreEmploi serviceOffre = null;
  try {
    serviceOffre = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
  } catch (Exception e) {
%>
<h4>[ERROR] lors de l'initialisation de service Candidat</h4>
<%
  }
  String erreur = null;
  String idStringValue = request.getParameter("id");
  int id = -1;
  OffreEmploi offreEmploi = null;

  if (idStringValue == null) {
    erreur = "Aucun identifiant de offreEmploi n'est fourni dans la demande.";
  } else {
    try {
      id = Integer.parseInt(idStringValue);
      // C'est OK : on a bien un id
      IServiceOffreEmploi serviceOffreEmploi = (IServiceOffreEmploi) ServicesLocator.getInstance().getRemoteInterface("ServiceOffreEmploi");
      offreEmploi = serviceOffreEmploi.getOffreEmploi(id);
      if (offreEmploi == null) {
        erreur = "Aucune offreEmploi ne correspond à cet identifiant : " + id;
      }
    } catch (NumberFormatException e) {
      erreur = "La valeur de l'identifiant n'est pas numérique";
    }
  }
%>

<div class="row">
  <div class="col-lg-12">
    <div class="panel panel-default">
      <div class="panel-heading"><h3><i class="fa fa-th"></i> Informations sur les offres</h3></div>
      <!-- /.panel-heading -->
      <div class="panel-body">
        <%
          if (erreur != null) // Une erreur a été détectée et est affichée.
          {
        %>
        <div class="row col-xs-offset-1 col-xs-10">
          <div class="panel panel-red">
            <div class="panel-heading ">
              Impossible de traiter la demande
            </div>
            <div class="panel-body text-center">
              <p class="text-danger"><strong><%=erreur%>
              </strong></p>
            </div>
          </div>
        </div> <!-- /.row col-xs-offset-1 col-xs-10 -->
        <%
        } else {
        %>
        <div class="table-responsive">
          <small>
            <table class="table">
              <tbody>
              <tr class="success">
                <td width="200"><strong>Identifiant (login)</strong></td>
                <td>OE_<%=offreEmploi.getIdOffre()%>
                </td>
              </tr>
              <tr class="warning">
                <td width="200"><strong>Titre</strong></td>
                <td><%=offreEmploi.getTitre()%>
                </td>
              </tr>
              <tr class="warning">
                <td width="200"><strong>MessageCandidat</strong></td>
                <td><%=offreEmploi.getMessageCandidats()%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Descriptif</strong></td>
                <td><%=offreEmploi.getDescriptif()%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Profil recherché</strong></td>
                <td><%=offreEmploi.getProfilRecherche()%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Nom de l'entreprise qui l'a publié</strong></td>
                <td><%=offreEmploi.getEntreprise().getNom()%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Niveau qualification</strong></td>
                <td><%=offreEmploi.getNiveauQualification().getIntituleQualification()%></td>

                </td>
              </tr>
              <tr class="warning">
                <td><strong>Secteur activite</strong></td>
                <td><%=serviceOffre.GetSecteursString(offreEmploi)%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Date de depot</strong></td>
                <td><%=offreEmploi.getDateDepot()%>
                </td>
              </tr>
              <tr class="warning">
                <td><strong>Date de dépot</strong></td>
                <td><%=offreEmploi.getDateDepot().toString()%>
                </td>
              </tr>

              </tbody>
            </table>
          </small>
        </div>
        <%
          }
        %>
      </div> <!-- /.panel-body -->
    </div> <!-- /.panel -->
  </div> <!-- /.col-lg-12 -->
</div>
<!-- /.row -->