var gIdPersona="";
window.onload = function () {
    _Load.Close();
    _Usuario = sessionStorage.getItem("JUsuario").split(_sepFields);
    _Area = "Personal"
    _Controller = "Persona"
    _Url = _Area + "/" + _Controller + "/";
    setEvents();
    ListaPersona();
}

function setEvents() {
    btnAgregar.onclick = function () {
        CardUser.classList.remove("gz-hide");
    }

    btnCancelar.onclick = function () {
        CardUser.classList.add("gz-hide");
    }

    btnGuardar.onclick = function () {
        if (!Valida.ValidarDatos("R")) {
            Notify.Show('e', 'Debe llenar campos requeridos (*)');
            return;
        }
        if (gIdPersona) {
            let text = "¿Está seguro de actualizar el registro?";
            new oDialog(text,
                {
                    title: 'Persona - Modificar',
                    positive: {
                        text: 'Aceptar',
                        action: function () {
                            Grabar();
                        }
                    },
                    negative: {
                        text: 'Cancelar',
                    },
                    animate: oDialog.ANIMATE.FADE
                }).show();
        }
        else {
            Grabar();
        }
    }
}

function ListaPersona() {
    Http.get(_Url + "ListaPersona", mostrarLista);
}

function mostrarLista(rpta) {
    if (rpta) {
        var Lista = rpta.split(_sepTables);
        var ListaTab = Lista[0].split(_sepRows);
        var ListaCombo = Lista[1].split(_sepRows);

        UI.Combo(cboTipoPersona, ListaCombo, 0);

        var opts = {
            Id: "Persona",
            DataTable: ListaTab,
            RowsForPage: 10,
            ReportTitle: "Lista Persona",
            HasEdit: true,
            HasDelete: true,
            HasExport: true
        }
        UI.Grid(divPersona, opts);
    }
}

function Grabar() {
    var data = gIdPersona + "|" + GUI.ObtenerDatos("G");
    var frm = new FormData();
    frm.append("Data", data);
    Http.post(_Url + "GrabaPersona", rptaGrabar, frm);
}

function rptaGrabar(rpta) {
    if (rpta.includes("Duplicado")){
        Notify.Show('e', 'DNI ya existe');
    }
    else {
        LimpiaControl();
        Notify.Show('s', 'Registro guardado');
        ListaPersona();
        CardUser.classList.add("gz-hide");
    }
}

function LimpiaControl() {
    txtNudocumento.value = "";
    txtNombre.value = "";
    txtApePaterno.value = "";
    txtApeMaterno.value = "";
    chkMasculino.checked = false;
    chkFemenino.checked = false;
    txtTelefono.value = "";
    txtCorreo.value = "";
    txtDireccion.value = "";
}