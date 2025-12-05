import SwiftUI

struct DiaryListView: View {
    @StateObject private var diaryListVM = DiaryListViewModel()
    @EnvironmentObject private var appSession: AppSession
    private let padding: CGFloat = 24
    @State private var showFields = false

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            VStack {
                NavigationTitleView(title: "Meu Diário")
                    .animatedTitle(isVisible: showFields)

                diaryList
            }

            floatingActionButton
        }
        .padding(.horizontal, padding)
        .appBackground()
        .loader(diaryListVM.isLoading)
        .toolbar(content: toolbarContent)
        .task {
            guard let userID = appSession.getUserID() else {
                return appSession.signOut()
            }
            await diaryListVM.loadDiaryEntries(for: userID)
        }
        .onAppear(perform: executeAnimation)
        .environmentObject(appSession)
    }
}

// MARK: - Private Views
private extension DiaryListView {
    var diaryList: some View {
        List {
            ForEach(diaryListVM.diaryEntries) { entry in
                diaryCell(entry)
                    .onTapGesture { onTap(entry) }
            }
            .onDelete(perform: delete)
        }
        .background(Color.app(.background))
        .overlay(emptyList)
        .scrollContentBackground(.hidden)
        .listStyle(.plain)
        .refreshable(action: refreshList)
        .sheet(isPresented: $diaryListVM.isPresentingNewEntryModal) {
            DiaryEntryFormView(existingEntry: diaryListVM.entryBeingEdited,
                               onSave: saveAndCloseDiaryEntry)
        }
    }

    @ViewBuilder
    var emptyList: some View {
        if diaryListVM.getDiaries().isEmpty && !diaryListVM.isLoading {
            Text("Nenhuma entrada em seu diário!")
                .font(.body)
                .foregroundColor(Color.app(.textSecondary))
                .frame(maxWidth: .infinity,
                       maxHeight: .infinity,
                       alignment: .center)
                .background(Color.app(.background))
        }
    }

    func diaryCell(_ diary: DiaryEntry) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(formattedDate(diary.timestamp))
                    .font(.subheadline)
                    .foregroundColor(Color.app(.textSecondary))
                Spacer()
            }

            Divider()

            Text(diary.title)
                .font(.headline)
                .foregroundColor(Color.app(.textPrimary))
                .lineLimit(2)
                .fixedSize(horizontal: false, vertical: true)

            Text(diary.text)
                .font(.body)
                .foregroundColor(Color.app(.textSecondary))
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)

            HStack {
                Spacer()
                Text(diary.feeling.displayName)
                    .font(.caption)
                    .foregroundColor(Color.app(.buttonTextColor))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.app(.accent))
                    .cornerRadius(12)
            }
        }
        .padding(12)
        .background(Color.app(.componentBackground))
        .cornerRadius(12)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 8, trailing: 0))
        .listRowBackground(Color.app(.clear))
        .listRowSeparator(.hidden)
    }

    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MMMM 'de' yyyy"
        return formatter.string(from: date)
    }

    var floatingActionButton: some View {
        CircleButtonComponentView(type: .add) {
            addEntry()
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .animation(.easeInOut, value: diaryListVM.isPresentingNewEntryModal)
    }

    @ToolbarContentBuilder
    func toolbarContent() -> some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            NavigationLink {
                ProfileView()
            } label: {
                Image(systemName: "person.fill")
                    .foregroundColor(Color.app(.accent))
            }
        }
    }
}

// MARK: - Private Methods
private extension DiaryListView {
    func saveAndCloseDiaryEntry(_ entry: DiaryEntry) {
        guard let userID = appSession.getUserID() else { return }
        Task { await diaryListVM.saveDiaryEntry(entry, for: userID) }
    }

    func delete(at indexSet: IndexSet) {
        guard let userID = appSession.getUserID() else { return }
        Task { await diaryListVM.deleteDiaryEntry(at: indexSet, for: userID) }
    }

    func onTap(_ entry: DiaryEntry) {
        diaryListVM.editDiaryEntry(entry)
    }

    func addEntry() {
        diaryListVM.entryBeingEdited = nil
        diaryListVM.isPresentingNewEntryModal = true
    }

    func executeAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            showFields = true
        }
    }

    func refreshList() async {
        guard let userID = appSession.getUserID() else { return }
        await diaryListVM.loadDiaryEntries(for: userID)
    }
}

#Preview {
    DiaryListView()
}
