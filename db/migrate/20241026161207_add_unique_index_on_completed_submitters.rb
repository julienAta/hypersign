# frozen_string_literal: true

class AddUniqueIndexOnCompletedSubmitters < ActiveRecord::Migration[7.2]
  def up
    # Remove existing non-unique index if exists
    if connection.index_exists?(:completed_submitters, :submitter_id, name: 'index_completed_submitters_on_submitter_id')
      connection.execute("DROP INDEX IF EXISTS docuseal.index_completed_submitters_on_submitter_id")
    end

    # Add unique index if it doesn't exist
    unless connection.index_exists?(:completed_submitters, :submitter_id, unique: true)
      connection.add_index :completed_submitters, :submitter_id, unique: true
    end
  end

  def down
    # Remove unique index
    if connection.index_exists?(:completed_submitters, :submitter_id, unique: true)
      connection.remove_index :completed_submitters, :submitter_id
    end

    # Add back non-unique index
    unless connection.index_exists?(:completed_submitters, :submitter_id)
      connection.add_index :completed_submitters, :submitter_id
    end
  end
end
