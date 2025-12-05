import SwiftUI

struct DiaryEntryFormView: View {
    @StateObject private var diaryEntryFormVM: DiaryEntryFormViewModel
    @EnvironmentObject private var appSession: AppSession
    @Environment(\.dismiss) private var dismiss

    var onSave: (DiaryEntry) -> Void

    init(existingEntry: DiaryEntry? = nil,
         onSave: @escaping (DiaryEntry) -> Void) {
        let wrappedValue = DiaryEntryFormViewModel(existingEntry: existingEntry)
        self._diaryEntryFormVM = StateObject(wrappedValue: wrappedValue)
        self.onSave = onSave
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack(spacing: 16) {
                    ButtonComponentView(title: "Cancelar") {
                        dismiss()
                    }

                    NavigationTitleView(title: "Novo Registro", displayInline: true)

                    ButtonComponentView(title: "Salvar", action: saveEntry)
                        .disabled(diaryEntryFormVM.isSaveButtonDisabled())
                }
                .padding(.horizontal, 24)
                .padding(.top, 16)

                entryForm
            }
            .appBackground()
        }
    }
}

// MARK: - Private Views
private extension DiaryEntryFormView {
    var entryForm: some View {
        ScrollView {
            VStack(spacing: 24) {
                FormSectionView("Título") {
                    TextFieldComponentView(
                        title: "Digite o título",
                        value: $diaryEntryFormVM.title
                    )
                }

                FormSectionView("Sentimento") {
                    PickerComponentView(
                        title: "Selecione um sentimento",
                        options: FeelingType.allCases,
                        label: { $0.displayName },
                        selection: $diaryEntryFormVM.selectedFeeling
                    )
                }

                FormSectionView("Texto") {
                    TextEditorComponentView(
                        placeholder: "Digite sua anotação",
                        text: $diaryEntryFormVM.text,
                        minHeight: 164
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 16)
        }
    }
}

// MARK: - Private Methods
private extension DiaryEntryFormView {
    func saveEntry() {
        guard let userID = appSession.getUserID() else { return }
        let entry = diaryEntryFormVM.getDiaryEntry(for: userID)
        onSave(entry)
        dismiss()
    }
}

#Preview {
    DiaryEntryFormView() { _ in }
}
