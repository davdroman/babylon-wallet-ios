import FeaturePrelude
import ImportMnemonicFeature

extension SelectBackup {
	public typealias ViewState = State

	@MainActor
	public struct View: SwiftUI.View {
		private let store: StoreOf<SelectBackup>

		public init(store: StoreOf<SelectBackup>) {
			self.store = store
		}

		public var body: some SwiftUI.View {
			WithViewStore(store, observe: { $0 }, send: { .view($0) }) { viewStore in
				ScrollView {
					VStack(spacing: .medium1) {
						// FIXME: Strings
						Text("Select a backup to recover your Radix Wallet. You will be asked to enter your seed phrase(s) to recover control of your Accounts and Personas.")
							.textStyle(.body1Regular)

						// FIXME: Strings
						Text("Choose a backup on iCloud")
							.textStyle(.body1Header)

						backupsList(with: viewStore)

						// FIXME: Strings
						Button("Import from Backup File Instead") {
							viewStore.send(.importFromFileInstead)
						}
						.foregroundColor(.app.blue2)
						.font(.app.body1Header)
						.frame(height: .standardButtonHeight)
						.frame(maxWidth: .infinity)
						.padding(.medium1)
						.background(.app.white)
						.cornerRadius(.small2)
					}
					.foregroundColor(.app.gray1)
					.padding(.medium2)
				}
				.footer {
					WithControlRequirements(
						viewStore.selectedProfileHeader,
						forAction: { viewStore.send(.tappedUseCloudBackup($0)) },
						control: { action in
							Button(L10n.IOSProfileBackup.useICloudBackup, action: action)
								.buttonStyle(.primaryRectangular)
						}
					)
				}
				.sheet(
					store: store.scope(state: \.$destination, action: { .child(.destination($0)) }),
					state: /SelectBackup.Destinations.State.inputEncryptionPassword,
					action: SelectBackup.Destinations.Action.inputEncryptionPassword,
					content: { store in
						NavigationView {
							EncryptOrDecryptProfile.View(store: store)
						}
					}
				)
				.fileImporter(
					isPresented: viewStore.binding(
						get: \.isDisplayingFileImporter,
						send: .dismissFileImporter
					),
					allowedContentTypes: [.profile],
					onCompletion: { viewStore.send(.profileImportResult($0.mapError { $0 as NSError })) }
				)
			}
			.task { @MainActor in
				await ViewStore(store.stateless).send(.view(.task)).finish()
			}
			// FIXME: Strings
			.navigationTitle("Recover Wallet from Backup")
		}
	}
}

extension SelectBackup.View {
	@MainActor
	private func backupsList(with viewStore: ViewStoreOf<SelectBackup>) -> some SwiftUI.View {
		// TODO: This is speculative design, needs to be updated once we have the proper design
		VStack(spacing: .medium1) {
			if let backupProfileHeaders = viewStore.backupProfileHeaders {
				Selection(
					viewStore.binding(
						get: \.selectedProfileHeader,
						send: {
							.selectedProfileHeader($0)
						}
					),
					from: backupProfileHeaders
				) { item in
					cloudBackupDataCard(item, viewStore: viewStore)
				}
			} else {
				// FIXME: Strings (update: `noCloudBackup`)
				Text("No wallet backups available on current iCloud account")
					.foregroundColor(.app.gray2)
					.padding(.large1)
					.background(.app.gray5)
					.cornerRadius(.small1)
			}
		}
		.padding(.horizontal, .medium3)
	}

	@MainActor
	private func cloudBackupDataCard(_ item: SelectionItem<ProfileSnapshot.Header>, viewStore: ViewStoreOf<SelectBackup>) -> some View {
		let header = item.value
		let isVersionCompatible = header.isVersionCompatible()
		let creatingDevice = header.creatingDevice.id == viewStore.thisDeviceID ? L10n.IOSProfileBackup.thisDevice : header.creatingDevice.description.rawValue
//		let lastUsedOnDevice = header.lastUsedOnDevice.id == viewStore.thisDeviceID ? L10n.IOSProfileBackup.thisDevice : header.lastUsedOnDevice.description.rawValue

		return Card(action: item.action) {
			HStack {
				VStack(alignment: .leading, spacing: 0) {
					Group {
//						Text(L10n.IOSProfileBackup.creationDateLabel(formatDate(header.creationDate)))
						// FIXME: Strings
						Text("**Backup from**: \(creatingDevice)")
						// FIXME: update bolding of 'label'?
						Text(L10n.IOSProfileBackup.lastModifedDateLabel(formatDate(header.lastModified)))
//						Text(L10n.IOSProfileBackup.numberOfNetworksLabel(header.contentHint.numberOfNetworks))
						Text(L10n.IOSProfileBackup.totalAccountsNumberLabel(header.contentHint.numberOfAccountsOnAllNetworksInTotal))
						Text(L10n.IOSProfileBackup.totalPersonasNumberLabel(header.contentHint.numberOfPersonasOnAllNetworksInTotal))
					}
					.foregroundColor(.app.gray2)
					.textStyle(.body2Regular)

					if !isVersionCompatible {
						Text(L10n.IOSProfileBackup.incompatibleWalletDataLabel)
							.foregroundColor(.red)
							.textStyle(.body2HighImportance)
					}
				}
				if isVersionCompatible {
					Spacer()
					RadioButton(
						appearance: .dark,
						state: item.isSelected ? .selected : .unselected
					)
				}
			}
			.padding(.medium3)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
		.disabled(!isVersionCompatible)
	}

	@MainActor
	func formatDate(_ date: Date) -> String {
		date.ISO8601Format(.iso8601Date(timeZone: .current))
	}
}