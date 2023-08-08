// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'dart:io';

import 'package:app_aluno_registro/common.dart';
import 'package:app_aluno_registro/pages/Login.dart';

import 'package:app_aluno_registro/repositories/ambiente_aluno_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_aluno_registro/stores/document_renew_store.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:file_picker/file_picker.dart';

class DocumentRenew extends StatefulWidget {
  const DocumentRenew({Key? key}) : super(key: key);

  @override
  State<DocumentRenew> createState() => _DocumentRenewState();
}

class _DocumentRenewState extends State<DocumentRenew> {
  @override
  void initState() {
    super.initState();
  }

  File? certidaoFile;
  File? comprovanteResidenciaFile;
  File? fotoFile;
  File? comprovanteMatriculaFile;

  final documentRenewStore = DocumentRenewStore();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final campo_numero_sere = TextEditingController();

  dynamic ambiente_aluno = AmbienteAlunoRepository();
  dynamic dados;

  bool foi_tocado_certidao = false;
  bool foi_tocado_comprovante_residencia = false;
  bool foi_tocado_foto = false;
  bool foi_tocado_comprovante_matricula = false;

  Future<void> pickCertidaoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        certidaoFile = File(result.files.single.path!);
        foi_tocado_certidao = true;
      });
    }
  }

  Future<void> pickComprovanteResidenciaFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        comprovanteResidenciaFile = File(result.files.single.path!);
        foi_tocado_comprovante_residencia = true;
      });
    }
  }

  Future<void> pickFotoFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        fotoFile = File(result.files.single.path!);
        foi_tocado_foto = true;
      });
    }
  }

  Future<void> pickComprovanteMatriculaFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        comprovanteMatriculaFile = File(result.files.single.path!);
        foi_tocado_comprovante_matricula = true;
      });
    }
  }

  getControllerValues() async {
    if (documentRenewStore.isValid) {
      dados = {
        'numero_sere': documentRenewStore.numeroSere,
        'foto': fotoFile?.path,
        'certidao_nasc': certidaoFile?.path,
        'comprovante_residencia': comprovanteResidenciaFile?.path,
        'comprovante_matricula': comprovanteMatriculaFile?.path
      };
      final response = await ambiente_aluno.renovaDocumentos(dados);

      List<dynamic> errorMessages = [];

      if (response != null) {
        response.forEach((key, value) {
          errorMessages.addAll(value);
        });

        // ignore: use_build_context_synchronously
        Common.displayError(
            context, 'Erro!!', errorMessages.join(', ').toString());
      } else {
        Common.displaySuccess(context, 'Sucesso!',
            'Seus documentos foram enviados para revisão', true);
      }
    } else {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Reenvio de Documentos',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(12.0),
          padding: const EdgeInsets.only(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Observer(builder: (_) {
                    return TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      controller: campo_numero_sere,
                      keyboardType: TextInputType.number,
                      autofocus: true,
                      onChanged: (value) =>
                          documentRenewStore.numeroSere = value,
                      decoration: InputDecoration(
                        isDense: true,
                        labelStyle: Theme.of(context).textTheme.bodyMedium,
                        labelText: "Numero Sere",
                        errorText: documentRenewStore.validateNumeroSere(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      maxLines: 1,
                      maxLength: TextField.noMaxLength,
                    );
                  }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickCertidaoFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text(
                          'Certidao',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    if (foi_tocado_certidao && certidaoFile != null)
                      Image.file(
                        File(certidaoFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickComprovanteMatriculaFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text('Comprovante',
                            style: Theme.of(context).textTheme.headlineSmall),
                      ),
                    ),
                    if (foi_tocado_comprovante_matricula &&
                        comprovanteMatriculaFile != null)
                      Image.file(
                        File(comprovanteMatriculaFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickComprovanteResidenciaFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text(
                          'Residencia',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    if (foi_tocado_comprovante_residencia &&
                        comprovanteResidenciaFile != null)
                      Image.file(
                        File(comprovanteResidenciaFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                      width: MediaQuery.of(context).size.width * 0.33,
                      child: ElevatedButton(
                        onPressed: () {
                          pickFotoFile();
                        },
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: Theme.of(context).colorScheme.inversePrimary,
                          // ignore: deprecated_member_use
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                        child: Text(
                          'Foto',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                    ),
                    if (foi_tocado_foto && fotoFile != null)
                      Image.file(
                        File(fotoFile!.path),
                        fit: BoxFit.cover,
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.4,
                      ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.12,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    getControllerValues();
                  },
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: Theme.of(context).colorScheme.inversePrimary,
                    // ignore: deprecated_member_use
                    onPrimary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'Cadastrar',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
